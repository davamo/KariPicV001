class AddCaptionIdToPhotos < ActiveRecord::Migration[7.0]
  def change
    add_reference :photos, :caption, null: false, foreign_key: true
  end
end
