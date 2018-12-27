class CreateSimilars < ActiveRecord::Migration
  def change
    create_table :similars do |t|
      t.integer :maincourse_id, index: true
      t.integer :simcourse_id, index: true
      
      t.timestamps null: false
    end
    add_index :similars, [:maincourse_id, :simcourse_id], unique: true
  end
end
