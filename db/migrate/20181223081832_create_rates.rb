class CreateRates < ActiveRecord::Migration
  def change
    create_table :rates do |t|
      t.integer :average_rate
      t.string :difficulty
      t.string :homework
      t.string :grading
      t.string :gain
      t.references :course, foreign_key: true

      t.timestamps null: false
    end
  end
end
