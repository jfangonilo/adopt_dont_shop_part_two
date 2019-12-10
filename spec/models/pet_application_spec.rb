require "rails_helper"

describe PetApplication do
  describe "relationships" do
    it {should belong_to :pet}
    it {should belong_to :application}
  end

  describe "validations" do
    it {should validate_presence_of :pet_id} 
    it {should validate_presence_of :application_id}
  end

  describe "methods" do
    it ".toggle_pending" do
      app = create(:application)
      pet = create(:random_pet)
      app.pets << pet
      pet_app = app.pet_applications.first
      expect(pet_app.pending).to eq false
      pet_app.toggle_pending
      expect(pet_app.pending).to eq true
    end
  end
end