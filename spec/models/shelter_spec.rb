require 'rails_helper'

describe Shelter, type: :model do
  before :each do
    @shelter_1 = create(:random_shelter, name: "Winterfell")
    @shelter_2 = create(:random_shelter, name: "Sunspear")

    @pet_1 = create(:random_pet, shelter: @shelter_1)
    @pet_2 = create(:random_pet, shelter: @shelter_1)
  end

  describe "validations" do
    it {should validate_presence_of :name}
    it {should validate_presence_of :address}
    it {should validate_presence_of :city}
    it {should validate_presence_of :state}
    it {should validate_presence_of :zip}
  end

  describe "relationships" do
    it {should have_many :pets}
    it {should have_many :shelter_reviews}
  end

  describe "method" do
    it ".pet_count" do
      expect(@shelter_1.pet_count).to eq 2
    end

    
  end

  describe "class method" do
    it ".alpha_sort" do
      expect(Shelter.all).to match_array [@shelter_1, @shelter_2]
      expect(Shelter.alpha_sort).to match_array [@shelter_2, @shelter_1]
    end
  end
end
