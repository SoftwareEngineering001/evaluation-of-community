class CreateInstructions < ActiveRecord::Migration
  def change
    create_table :instructions do |t|
      t.belongs_to :teacher, index: true
      t.belongs_to :course, index: true

      t.timestamps null: false
    end
  end
end
