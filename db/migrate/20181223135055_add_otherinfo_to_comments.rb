class AddOtherinfoToComments < ActiveRecord::Migration
  def change
    add_column :comments, :upvote_count, :integer
    add_column :comments, :comment_count, :integer
  end
end
