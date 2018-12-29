class AddCourseidToRates < ActiveRecord::Migration
  def change
    add_column :rates, :course_id, :integer
  end
end
