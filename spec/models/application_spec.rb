require "rails_helper"

describe Application do
  describe "relationships" do
    it {should have_many :pet_applications}
    it {should have_many(:pets).through(:pet_applications)}
  end

  describe "validations" do
    it {should validate_presence_of :name}
    it {should validate_presence_of :address}
    it {should validate_presence_of :city}
    it {should validate_presence_of :state}
    it {should validate_presence_of :zip}
    it {should validate_presence_of :phone_number}
    it {should validate_presence_of :description}
  end

  describe "#deny_approval" do
    it "denies application approval" do
      pet = create(:random_pet)
      application = create(:application)
      application.pets << pet

      pet.deny_approval

      expect(current_path).to eq("/applications/#{application.id}")
      expect(page).to have_content("#{pet.name} is already pending adoption! No more adoption approvals can be made at this time.")
      
    end
  end
end
