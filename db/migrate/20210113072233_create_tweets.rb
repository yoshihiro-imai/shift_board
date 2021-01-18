class CreateTweets < ActiveRecord::Migration[6.0]
  def change
    create_table :tweets do |t|
      t.string :title,     null:false
      t.string :context,   null:false
      t.references :user,  foreign_key: true
      t.integer :counts_like
      t.timestamps
    end
  end
end
