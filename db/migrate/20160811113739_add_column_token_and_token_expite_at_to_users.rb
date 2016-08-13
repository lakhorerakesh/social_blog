class AddColumnTokenAndTokenExpiteAtToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :token, :string
    add_column :users, :token_expire_at, :datetime
  end
end
