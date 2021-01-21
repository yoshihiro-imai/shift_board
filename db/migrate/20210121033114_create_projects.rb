class CreateProjects < ActiveRecord::Migration[6.0]
  def change
    create_table :projects do |t|
      t.integer :month, null: false
      t.references :user,  foreign_key: true


      t.timestamps
    end
  end
end
