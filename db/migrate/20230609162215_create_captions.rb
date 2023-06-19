class CreateCaptions < ActiveRecord::Migration[7.0]
  def change
    create_table :captions do |t|
      t.integer :photo_id
      t.integer :user_id
      t.string :text
      t.timestamps
    end
  end
end
