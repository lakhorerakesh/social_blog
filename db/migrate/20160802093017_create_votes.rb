class CreateVotes < ActiveRecord::Migration[5.0]
  def change
    create_table :votes do |t|
      t.integer :post_id, index:true
      t.integer :user_id, index:true
      t.boolean :vote
      t.timestamps
    end
  end
end
