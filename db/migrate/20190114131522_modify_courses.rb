class ModifyCourses < ActiveRecord::Migration
  def change
    remove_column :courses, :comment_counts, :term, :teacher
    add_column :courses, :code, :string
    add_column :courses, :title_en, :string
    add_column :courses, :period_credit, :string
    add_column :courses, :subject, :string
    add_index :courses, :code, unique: true
  end
end
