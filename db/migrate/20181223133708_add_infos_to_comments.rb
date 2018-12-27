class AddInfosToComments < ActiveRecord::Migration
  def change
    add_column :comments, :difficulty, :string
    add_column :comments, :homework, :string
    add_column :comments, :grading, :string
    add_column :comments, :gain, :string
    add_column :comments, :rate, :integer
  end
end
