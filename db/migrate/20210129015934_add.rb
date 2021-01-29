class Add < ActiveRecord::Migration[6.0]
  def change
    add_column :tweets, :image, :text
  end
end
