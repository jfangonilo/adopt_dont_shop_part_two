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

  it "shows a message if you have no pets in your favorites" do
    visit "/favorites"
    expect(page).to have_content "How could you be so heartless??? You don't have any favorites yet!"

    pet = create(:random_pet)
    visit "/pets/#{pet.id}"
    click_button "Add #{pet.name} to Favorites"

    visit "/favorites"
    expect(page).not_to have_content "How could you be so heartless??? You don't have any favorites yet!"
  end

  it "can remove all pets from favorites" do
    pet_1 = create(:random_pet)
    visit "/pets/#{pet_1.id}"
    click_button "Add #{pet_1.name} to Favorites"

    pet_2 = create(:random_pet)
    visit "/pets/#{pet_2.id}"
    click_button "Add #{pet_2.name} to Favorites"

    visit '/favorites'

    click_link "Remove All Favorites"
    expect(page).to have_content "Favorites: 0"
  end


#   User Story 18, List of Pets that have applications on them
#
# As a visitor
# After one or more applications have been created
# When I visit the favorites index page
# I see a section on the page that has a list of all of the pets that have at least one application on them
# Each pet's name is a link to their show page

  it "shows all pets with applications" do
    pet_1 = create(:random_pet)
    pet_2 = create(:random_pet)
    pet_3 = create(:random_pet)

    visit "/pets/#{pet_1.id}"
    click_button "Add #{pet_1.name} to Favorites"

    visit "/pets/#{pet_2.id}"
    click_button "Add #{pet_2.name} to Favorites"

     visit "/pets/#{pet_3.id}"
    click_button "Add #{pet_3.name} to Favorites"

    application_1 = create(:application)
    application_1.pets << pet_1
    application_2 = create(:application)
    application_2.pets << pet_1
    application_3 = create(:application)
    application_3.pets << pet_2

    visit '/favorites'
    within "#favorites-list" do
      click_link("#{pet_1.name}")
      expect(current_path).to eq("/pets/#{pet_1.id}")
    end

    visit '/favorites'
    within "#favorites_list" do
      click_link("#{pet_2.name}")
      expect(current_path).to eq("/pets/#{pet_2.id}")
    end

    visit '/favorites'
    within "#favorites_list" do
    expect(page).not_to have_link("#{pet_3.name}")
    end
  end

end
