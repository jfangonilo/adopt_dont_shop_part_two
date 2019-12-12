class Shelter < ApplicationRecord
  validates_presence_of :name
  validates_presence_of :address
  validates_presence_of :city
  validates_presence_of :state
  validates_presence_of :zip

  has_many :pets, dependent: :destroy
  has_many :shelter_reviews

  def pet_count
    pets.length
  end

  def self.alpha_sort
    order(name: :ASC)
  end

  def pets_pending?
    pets.where(adoptable: false).any?
  end

  def average_rating
    shelter_reviews.average(:rating)
  end

  def applications_count
    pets.joins(:applications).select(:application_id).distinct.length
  end
end
