class Shelter < ApplicationRecord
  validates_presence_of :name
  validates_presence_of :address
  validates_presence_of :city
  validates_presence_of :state
  validates_presence_of :zip

  has_many :pets
  has_many :shelter_reviews

  def pet_count
    pets.length
  end

  def self.alpha_sort
    all.order(name: :ASC)
  end
end
