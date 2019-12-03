class ShelterReview < ApplicationRecord
  validates_presence_of :title, :rating, :content
  validates_numericality_of :rating

  belongs_to :shelter
end
