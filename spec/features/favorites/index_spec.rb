require 'rails_helper'

RSpec.describe "favorites index page" do
  it "displays all favorited pets, with name and image" do
    pet_1 = create(:random_pet)
    pet_2 = create(:random_pet)

    visit "/pets/#{pet_1.id}"
    click_button "Add #{pet_1.name} to Favorites"

    visit "/pets/#{pet_2.id}"
    click_button "Add #{pet_2.name} to Favorites"

    visit '/favorites'

    expect(page).to have_content(pet_1.name)
    expect(page).to have_css("img[src = '#{pet_1.image}']")
    expect(page).to have_content(pet_2.name)
    expect(page).to have_css("img[src = '#{pet_2.image}']")
  end
end
