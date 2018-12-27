class CreateAttitudes < ActiveRecord::Migration
  def change
    create_table :attitudes do |t|
      t.integer :user_id, index: true
      t.integer :course_id, index: true
      t.boolean :has_follow, default: false
      t.boolean :has_recom, default: false
      t.boolean :has_disrecom, default: false
      t.boolean :has_learn, default: false

      t.timestamps null: false
    end
    add_index :attitudes, [:user_id, :course_id], unique: true
  end
end
