require 'rails_helper'

RSpec.describe "a user can remove individual pets from favorites" do

  it "remove from favorites button removes pet from favorites" do
    pet_1 = create(:random_pet)

    visit "/pets/#{pet_1.id}"
    click_button "Add #{pet_1.name} to Favorites"
    within ".topnav" do
      expect(page).to have_content("Favorites: 1")
    end
    click_button "Remove #{pet_1.name} from Favorites"

    visit "/favorites"
    expect(page).not_to have_content("#{pet_1.name}")
    expect(page).not_to have_css("img[src = '#{pet_1.image}']")
    within ".topnav" do
      expect(page).to have_content("Favorites: 0")
    end
  end

  it "add to favorites button appears when pet not in favorites and remove from favorites button appears when pet in favorites" do
    pet_1 = create(:random_pet)

    visit "/pets/#{pet_1.id}"
    expect(page).not_to have_content("Remove #{pet_1.name} from Favorites")

    click_button "Add #{pet_1.name} to Favorites"
    expect(current_path).to eq("/pets/#{pet_1.id}")
    expect(page).not_to have_button("Add #{pet_1.name} to Favorites")
    expect(page).to have_button("Remove #{pet_1.name} from Favorites")

    click_button "Remove #{pet_1.name} from Favorites"
    expect(current_path).to eq("/pets/#{pet_1.id}")
    expect(page).not_to have_button("Remove #{pet_1.name} from Favorites")
    expect(page).to have_button("Add #{pet_1.name} to Favorites")
  end

  it "remove from favorites button redirects to pet show page and displays flash message" do
    pet_1 = create(:random_pet)

    visit "/pets/#{pet_1.id}"
    click_button "Add #{pet_1.name} to Favorites"
    click_button "Remove #{pet_1.name} from Favorites"

    expect(current_path).to eq("/pets/#{pet_1.id}")
    expect(page).to have_content("#{pet_1.name} has been removed from your favorites.")
  end

  it "remove from favorites decreases nav favorites counter by one" do
    pet_1 = create(:random_pet)

    visit "/pets/#{pet_1.id}"
    click_button "Add #{pet_1.name} to Favorites"
    within ".topnav" do
      expect(page).to have_content("Favorites: 1")
    end

    click_button "Remove #{pet_1.name} from Favorites"
    within ".topnav" do
      expect(page).to have_content("Favorites: 0")
    end
  end
end
