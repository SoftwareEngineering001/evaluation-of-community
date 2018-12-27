class CreateAttitudeToComments < ActiveRecord::Migration
  def change
    create_table :attitude_to_comments do |t|
      t.string :user_id, index: true
      t.string :comment_id, index: true

      t.timestamps null: false
    end
    add_index :attitude_to_comments, [:user_id, :comment_id], unique: true
  end
end
