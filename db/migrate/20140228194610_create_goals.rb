class CreateGoals < ActiveRecord::Migration
  def change
    create_table :goals do |t|
      t.string :title, :null => false
      t.text :description
      t.integer :user_id, :null => false, :references => :users
      t.boolean :completed, :default => false
      t.boolean :public, :default => false

      t.timestamps
    end
    add_index :goals, :title
    add_index :goals, :user_id
    add_index :goals, [:user_id, :completed]
    add_index :goals, [:user_id, :public]
  end
end
