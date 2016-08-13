class AddColumnsToUserForFacebookData < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :image, :string
    add_column :users, :location, :string
  end
end
