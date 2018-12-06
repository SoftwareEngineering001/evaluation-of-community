class ModifyUsers < ActiveRecord::Migration
  def change
    add_index :users, :email, unique: true
    add_index :users, :name, unique: true
    add_column :users, :password_digest, :string
  end
end
