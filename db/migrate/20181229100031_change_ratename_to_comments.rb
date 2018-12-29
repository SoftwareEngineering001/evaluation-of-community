class ChangeRatenameToComments < ActiveRecord::Migration
  def change
    rename_column :comments, :rate, :ratescore
  end
end
