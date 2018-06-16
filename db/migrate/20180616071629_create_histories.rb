class CreateHistories < ActiveRecord::Migration[5.1]
  def change
    create_table :histories do |t|
      t.integer :exchange_type
      t.integer :exchange_value
      t.string :content
      t.integer :user_id, index: true
      t.integer :friend_id

      t.timestamps
    end
  end
end
