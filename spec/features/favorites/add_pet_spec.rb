require 'rails_helper'

RSpec.describe "When a user adds a pet to their favorites" do
  it "displays message that pet was added to favorites" do
    pet = create(:random_pet)

    visit "/pets/#{pet.id}"

    click_button "Add #{pet.name} to Favorites"

    expect(page).to have_content("#{pet.name} has been added to your favorites!")
  end

  it "displays count of all favorites" do
    pet_1 = create(:random_pet)
    visit "/pets/#{pet_1.id}"
    click_button "Add #{pet_1.name} to Favorites"

    within ".navbar" do
      expect(page).to have_content("Favorites: 1")
    end

    pet_2 = create(:random_pet)
    visit "/pets/#{pet_2.id}"
    click_button "Add #{pet_2.name} to Favorites"

    within ".navbar" do
      expect(page).to have_content("Favorites: 2")
    end
  end
end
