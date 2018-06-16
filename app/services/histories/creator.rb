module Histories
  class Creator
    attr_reader :user_id, :friend_id, :exchange_value, :content, :exchange_type

    def initialize args
      @user_id = args[:user_id]
      @friend_id = args[:friend_id]
      @exchange_type = args[:exchange_type]
      @exchange_value = args[:exchange_value]
      @content = args[:content]
    end

    def call
      History.create! user_id: user_id, friend_id: friend_id,
        exchange_type: exchange_type, exchange_value: exchange_value,
        content: content
    end
  end
end
