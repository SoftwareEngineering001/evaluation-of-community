class AddHomepageToTeachers < ActiveRecord::Migration
  def change
    add_column :teachers, :homepage, :string
  end
end
