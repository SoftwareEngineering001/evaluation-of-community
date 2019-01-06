class DropInterestCourses < ActiveRecord::Migration
  def change
    drop_table :interest_courses
  end
end
