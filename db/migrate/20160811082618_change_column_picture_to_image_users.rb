class ChangeColumnPictureToImageUsers < ActiveRecord::Migration[5.0]
  def self.up
    rename_column :users, :picture, :image
  end
end
