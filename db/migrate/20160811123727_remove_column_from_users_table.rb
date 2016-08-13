class RemoveColumnFromUsersTable < ActiveRecord::Migration[5.0]
  def change
    remove_column :users, :secret, :datetime
  end
end
