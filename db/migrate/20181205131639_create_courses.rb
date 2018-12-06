class CreateCourses < ActiveRecord::Migration
  def change
    create_table :courses do |t|
      t.text :title
      t.text :teacher

      t.timestamps null: false
    end
  end
end
