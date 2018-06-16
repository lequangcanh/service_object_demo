class History < ApplicationRecord
  belongs_to :user

  enum exchange_type: %i(sender receiver)
end
