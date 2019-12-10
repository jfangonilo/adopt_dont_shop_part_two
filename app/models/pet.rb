class Pet < ApplicationRecord
  validates_presence_of :image
  validates_presence_of :name
  validates_presence_of :approximate_age
  validates_presence_of :sex
  validates_presence_of :description
  validates_presence_of :adoptable

  validates_numericality_of :approximate_age

  belongs_to :shelter
  has_many :pet_applications, dependent: :destroy
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
  end

  def applicant_id
    pet_applications.find_by(pending: true).application.id
  end

  def self.find_all_with_applications
    pets = Pet.select('pets.*').joins(:applications)
  end

  def pending_adoption?
    true if pet_applications.find_by(pending: :true)
  end
end
