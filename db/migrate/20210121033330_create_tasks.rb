class CreateTasks < ActiveRecord::Migration[6.0]
  def change
    create_table :tasks do |t|
      t.integer :date , null: false
      t.integer :intime, null: false
      t.integer :outtime, null: false
      t.belongs_to :project

      t.timestamps
    end
  end
end
