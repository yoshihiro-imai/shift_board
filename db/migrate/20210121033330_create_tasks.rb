class CreateTasks < ActiveRecord::Migration[6.0]
  def change
    create_table :tasks do |t|
      t.datetime :start_time, null: false
      t.datetime :intime, null: false
      t.datetime :outtime, null: false
      t.belongs_to :project,foreign_key: true, index: false, null: false
      t.timestamps
    end

    add_index :tasks,[:start_time,:project_id], unique: true
  end
end
