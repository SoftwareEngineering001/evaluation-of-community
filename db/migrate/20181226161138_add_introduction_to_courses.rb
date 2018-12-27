class AddIntroductionToCourses < ActiveRecord::Migration
  def change
    add_column :courses, :introduction, :text
  end
end
