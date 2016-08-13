class CreatePosts < ActiveRecord::Migration[5.0]
  def self.up
    create_table :posts do |t|
      t.belongs_to :user, index: true
      t.string :title
      t.string :description
      t.string :catagory
      t.timestamps
    end
  end
end
      