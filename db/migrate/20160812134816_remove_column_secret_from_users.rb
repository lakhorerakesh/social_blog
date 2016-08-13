class RemoveColumnSecretFromUsers < ActiveRecord::Migration[5.0]
  def change
    remove_column :users, :secret, :string
  end
end
