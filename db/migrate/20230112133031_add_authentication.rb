class AddAuthentication < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :password_hash, :string
    add_column :users, :password_salt, :string
    remove_column :users, :password
  end
end
