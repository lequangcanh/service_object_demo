class HistoryPresenter < BasePresenter
  def exchange
    if model.sender?
      "- #{model.exchange_value}"
    else
      "+ #{model.exchange_value}"
    end
  end

  def interactive_people
    User.find_by(id: model.friend_id)&.email
  end
end
