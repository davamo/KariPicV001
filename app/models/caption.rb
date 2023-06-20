class Caption < ApplicationRecord
  belongs_to :user
  has_many :photos

  validates :text, presence: true
end
