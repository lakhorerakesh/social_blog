class RemoveColumnsFromUsers < ActiveRecord::Migration[5.0]
  def change
    remove_column :users, :provider, :string
    remove_column :users, :uid, :string
    remove_column :users, :token, :string
    remove_column :users, :token_expire_at, :datetime
    remove_column :users, :image, :string
  end
end
