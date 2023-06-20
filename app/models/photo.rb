class Photo < ApplicationRecord
  belongs_to :caption
  has_one_attached :image

  validate :validate_image_presence

  def validate_image_presence
    unless image.attached?
      errors.add(:image, 'Debe seleccionar una imagen')
    end
  end
end
