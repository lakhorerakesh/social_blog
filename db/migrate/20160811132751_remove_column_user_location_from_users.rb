class RemoveColumnUserLocationFromUsers < ActiveRecord::Migration[5.0]
  def change
    remove_column :users, :user_location, :string
  end
end
