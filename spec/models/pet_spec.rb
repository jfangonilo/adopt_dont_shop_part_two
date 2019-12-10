require 'rails_helper'

describe Pet, type: :model do
  before :each do
    shelter_1 = Shelter.create!(
      name:     "House of Seamus",
      address:  "6303 W Exposition Ave",
      city:     "Lakewood",
      state:    "CO",
      zip:      "80226"
    )

    @pet_1 = shelter_1.pets.create!(
      image:            "string",
      name:             "Seamus",
      approximate_age:  8,
      sex:              "M",
      description:      "Winter is Coming, dog"
    )

    @pet_2 = shelter_1.pets.create(
      image:            "https://www.catster.com/wp-content/uploads/2018/03/Calico-cat.jpg",
      name:             "Miso",
      approximate_age:  2,
      sex:              "female",
      description:      "Winter is Coming; cat"
    )
  end

  describe "validations" do
    it {should validate_presence_of :image}
    it {should validate_presence_of :name}
    it {should validate_presence_of :approximate_age}
    it {should validate_presence_of :sex}
    it {should validate_presence_of :description}
    it {should validate_presence_of :adoptable}

    it {should validate_numericality_of :approximate_age}
  end

  describe "relationships" do
    it {should belong_to :shelter}
    it {should have_many :pet_applications}
    it {should have_many(:applications).through(:pet_applications)}
  end

  describe "instance method" do
    it ".shelter_name" do
      expect(@pet_1.shelter_name).to eq "House of Seamus"
    end

    it ".adoptable? initially returns adoptable" do
      expect(@pet_1.adoptable?).to eq true
    end

    it ".toggle_adoptable" do
      @pet_1.toggle_adoptable
      expect(@pet_1.adoptable?).to eq false
    end

    it ".applicant_name" do
      app_1 = create(:application)
      app_2 = create(:application)

      app_1.pets << @pet_1
      app_2.pets << @pet_1
      app_1.pet_applications.first.update(pending: true)
      expect(@pet_1.applicant_name).to eq app_1.name
    end
  end

  describe "class method" do
    it ".sort_adoptable" do
      expect(Pet.all).to match_array [@pet_1, @pet_2]
      @pet_1.adoptable = false
      expect(Pet.sort_adoptable).to match_array [@pet_2, @pet_1]
    end

    it ".find_all_with_applications" do
      pet_1 = create(:random_pet)
      pet_2 = create(:random_pet)
      pet_3 = create(:random_pet)
      application = create(:application)

      application.pets << [pet_1, pet_2]

      expect(Pet.find_all_with_applications).to eq([pet_1, pet_2])
    end
  end
end
