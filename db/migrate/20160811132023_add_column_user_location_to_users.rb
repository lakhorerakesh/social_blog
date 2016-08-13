class AddColumnUserLocationToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :user_location, :string
  end
end
