class Pet < ApplicationRecord
  validates_presence_of :image
  validates_presence_of :name
  validates_presence_of :approximate_age
  validates_presence_of :sex
  validates_presence_of :description
  validates_presence_of :adoptable

  validates_numericality_of :approximate_age

  belongs_to :shelter
  has_many :pet_applications
  has_many :applications, through: :pet_applications

  def shelter_name
    shelter.name
  end

  def adoptable?
    adoptable
  end

  def toggle_adoptable
    toggle! :adoptable
  end

  def self.sort_adoptable
    order(adoptable: :DESC)
  end

  def applicant_name
    pet_applications.find_by(pending: true).application.name
    # pet_id = self.id
    # Pet.select('applications.name').joins(:pet_applications).joins(:applications).where('pet_applications.pending =  true').pluck('applications.name').first
  end

  def self.find_all_with_applications
    pets = Pet.select('pets.*').joins(:applications)
  end
end
