class HistoriesController < ApplicationController
  def index
    @histories = current_user.histories
  end

  def new
    @history = current_user.histories.new
  end

  def create
    exchange_obj = Money::Exchanger.new user: current_user, params: histories_params
    exchange_obj.call
    if exchange_obj.success?
      flash[:success] = "Your exchange is success"
      redirect_to histories_path
    else
      @history = current_user.histories.new histories_params
      flash[:error] = exchange_obj.errors
      render :new
    end

    # @history = current_user.histories.new histories_params
    # @history.assign_attributes exchange_type: :sender
    # if @history.exchange_value <= current_user.balance
    #   @history.save!
    #   current_user.update! balance: current_user.balance - @history.exchange_value
    #   receiver = User.find @history.friend_id
    #   receiver.update! balance: receiver.balance + @history.exchange_value
    #   receiver.histories.create! exchange_value: @history.exchange_value,
    #     content: @history.content, friend_id: current_user.id,
    #     exchange_type: :receiver
    #   flash[:success] = "Your exchange is success"
    #   redirect_to histories_path
    # else
    #   flash[:error] = "Your balance not enough"
    #   render :new
    # end
  end

  private
  def histories_params
    params.require(:history).permit :exchange_value, :content, :friend_id
  end
end
