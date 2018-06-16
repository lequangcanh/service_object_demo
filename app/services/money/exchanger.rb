module Money
  class Exchanger
    attr_reader :user, :receiver, :exchange_value, :content, :errors

    def initialize args
      @user = args[:user]
      @params = args[:params]
      load_history_params
      load_errors
    end

    def call
      ActiveRecord::Base.transaction do
        unless errors
          exhange_money
          create_history
        end
      end
    rescue => e
      @errors = e.message
    end

    def success?
      !errors
    end

    private
    def load_history_params
      @exchange_value = @params[:exchange_value].to_i
      @content = @params[:content]
      @receiver = User.find_by id: @params[:friend_id]
    end

    def can_exchange?
      exchange_value <= user.balance
    end

    def load_errors
      @errors = case true
      when !receiver
        "Receiver not found"
      when !can_exchange?
        "Your balance not enough"
      else
        nil
      end
    end

    def exhange_money
      user.update! balance: user.balance - exchange_value
      receiver.update! balance: receiver.balance + exchange_value
    end

    def create_history
      Histories::Creator.new(user_id: user.id, friend_id: receiver.id,
        exchange_value: exchange_value, exchange_type: :sender,
        content: content).call
      Histories::Creator.new(user_id: receiver.id, friend_id: user.id,
        exchange_value: exchange_value, exchange_type: :receiver,
        content: content).call
    end
  end
end
