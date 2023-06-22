class Caption < ApplicationRecord
  belongs_to :user
  has_many :photos
  has_many :comments

  validates :text, presence: true
end
