class AddLogoutTimeToUsers < ActiveRecord::Migration
  def change
    add_column :users, :logout_time, :datetime
  end
end
