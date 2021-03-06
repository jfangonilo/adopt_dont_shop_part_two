class Pet < ApplicationRecord
  validates_presence_of :image
  validates_presence_of :name
  validates_presence_of :approximate_age
  validates_presence_of :sex
  validates_presence_of :description
  validates_inclusion_of :adoptable, in: [true, false]

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

  def self.all_with_applications
    joins(:applications).distinct
  end

  def self.all_with_pending_application
    joins(:pet_applications).where(pet_applications: {pending: true})
  end

  def applicant_name
    pet_applications.find_by(pending: true).application.name
  end

  def applicant_id
    pet_applications.find_by(pending: true).application.id
  end

  def pending_adoption?
    pet_applications.where(pending: :true).any?
  end

  def find_application(id)
    pet_applications.find_by(application_id: id)
  end
end
