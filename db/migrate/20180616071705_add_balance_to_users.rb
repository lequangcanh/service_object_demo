class AddBalanceToUsers < ActiveRecord::Migration[5.1]
  def self.up
    add_column :users, :balance, :integer, default: 0
  end

  def self.down
    remove_column :users, :balance
  end
end
