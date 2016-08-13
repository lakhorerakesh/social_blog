class ChangeColumnCatagoryInPosts < ActiveRecord::Migration[5.0]
  def self.up
    rename_column :posts, :catagory, :category
  end
end
