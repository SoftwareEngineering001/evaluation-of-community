class AddInfosToCourses < ActiveRecord::Migration
  def change
    add_column :courses, :course_major, :string
    add_column :courses, :dept, :string
    add_column :courses, :course_type, :string
    add_column :courses, :credit, :integer
  end
end
