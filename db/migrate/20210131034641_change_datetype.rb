class ChangeDatetype < ActiveRecord::Migration[6.0]
  def change
    add_index :tasks, [:start_time,:project_id],unique: true

  end
end
