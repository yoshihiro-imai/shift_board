class CreateShifts < ActiveRecord::Migration[6.0]
  def change
    create_table :shifts do |t|
      t.date :date
      t.integer :shift_in
      t.integer :shift_out
      t.integer :user_id
      t.timestamps
    end
  end
end
