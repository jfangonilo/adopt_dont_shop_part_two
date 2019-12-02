require 'rails_helper'

describe "When I visit /pets/:id," do
  before :each do
    shelter_1 = Shelter.create!(
      name:     "Winterfell",
      address:  "6303 W Exposition Ave",
      city:     "Lakewood",
      state:    "CO",
      zip:      "80226"
    )

    @pet = shelter_1.pets.create!(
      image:            "https://www.allthingsdogs.com/wp-content/uploads/2018/12/Husky-Names-Feature.jpg",
      name:             "Seamus",
      approximate_age:  8,
      sex:              "male",
      description:      "Winter is Coming; dog"
    )

    visit "/pets/#{@pet.id}"
  end

  it "I see the pet with that id" do
    expect(page).to have_css "img[src *= 'Husky-Names-Feature.jpg']"
    expect(page).to have_content @pet.name
    expect(page).to have_content @pet.approximate_age
    expect(page).to have_content @pet.sex
    expect(page).to have_content @pet.description
    expect(page).to have_content "Adoptable"
  end

  it "I can navigate to /pets/:id/edit via link" do
    click_link "Update"

    expect(current_path).to eq "/pets/#{@pet.id}/edit"
  end

  it "I can delete a shelter via a link" do
    click_link "Delete"

    expect(current_path).to eq "/pets"
    expect(page).to_not have_css "img[src *= 'Husky-Names-Feature.jpg']"
    expect(page).to_not have_content @pet.name
    expect(page).to_not have_content @pet.approximate_age
    expect(page).to_not have_content @pet.sex
    expect(page).to_not have_content @pet.description
  end

  it "I can click a link to change the pet's status to Adoption Pending/Adoptable" do

    click_link "Change to Adoption Pending"
    expect(current_path).to eq "/pets/#{@pet.id}"
    within "#adoptable-status" do
      expect(page).to have_content "Adoption Pending"
      expect(page).to_not have_content "Adoptable"
    end

    click_link "Change to Adoptable"
    expect(current_path).to eq "/pets/#{@pet.id}"
    within "#adoptable-status" do
      expect(page).to_not have_content "Adoption Pending"
      expect(page).to have_content "Adoptable"
    end
  end
end
