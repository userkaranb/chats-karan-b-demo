class AddMessagesTable < ActiveRecord::Migration[5.1]
  def change
    create_table :messages do |t|
      t.integer :user_id, null:false
      t.integer :to_id, null:false
      t.string :body 
      t.timestamps
    end
  end
end
