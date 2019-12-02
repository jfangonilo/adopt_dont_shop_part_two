class Pet < ApplicationRecord
  validates_presence_of :image
  validates_presence_of :name
  validates_presence_of :approximate_age
  validates_presence_of :sex
  validates_presence_of :description
  validates_presence_of :adoptable

  validates_numericality_of :approximate_age

  belongs_to :shelter

  def shelter_name
    shelter.name
  end

  def adoptable?
    self.adoptable
  end

  def toggle_adoptable
    self.toggle! :adoptable
  end

  def self.sort_adoptable
    all.order(adoptable: :DESC)
  end
end
