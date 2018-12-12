class AddCommentCountsToCourses < ActiveRecord::Migration
  def change
    add_column :courses, :comment_counts, :decimal
  end
end
