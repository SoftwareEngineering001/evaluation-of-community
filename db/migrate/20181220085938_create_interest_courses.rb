class CreateInterestCourses < ActiveRecord::Migration
  def change
    create_table :interest_courses do |t|
      t.integer :course_id
      t.integer :user_id

      t.timestamps null: false
    end
    add_index :interest_courses, :course_id
    add_index :interest_courses, :user_id
    add_index :interest_courses, [:course_id, :user_id], unique: true
  end
end
