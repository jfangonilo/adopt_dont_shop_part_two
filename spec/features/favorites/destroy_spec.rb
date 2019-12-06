require 'rails_helper'

RSpec.describe "a user can remove individual pets from favorites" do
  it "button to remove pet appears if pet is in favorites and add to favorites button does not appear" do
    pet_1 = create(:random_pet)

    visit "/pets/#{pet_1.id}"
    click_button "Add #{pet_1.name} to Favorites"

    expect(current_path).to eq("/pets/#{pet_1.id}")
    expect(page).not_to have_button("Add #{pet_1.name} to Favorites")
    expect(page).to have_button("Remove #{pet_1.name} from Favorites")
  end

  xit "remove from favorites button removes pet from favorites" do
    pet_1 = create(:random_pet)

    visit "/pets/#{pet_1.id}"
    click_button "Add #{pet_1.name} to Favorites"

    click_button "Remove #{pet_1.name} from Favorites"

    expect(page).not_to have_button("Remove #{pet_1.name} from Favorites")
    expect(page).to have_button("Add #{pet_1.name} to Favorites")

    visit "/favorites"
    expect(page).not_to have_content("#{pet_1.name}")
    expect(page).not_to have_css("img[src = '#{pet_1.image}']")
  end
end
