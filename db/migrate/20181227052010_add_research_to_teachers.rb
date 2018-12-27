class AddResearchToTeachers < ActiveRecord::Migration
  def change
    add_column :teachers, :research, :string
  end
end
