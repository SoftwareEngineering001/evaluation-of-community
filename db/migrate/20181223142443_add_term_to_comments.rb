class AddTermToComments < ActiveRecord::Migration
  def change
    add_column :comments, :term, :string
  end
end
