require "rails_helper"

describe "favorite pets show page" do
  it "shows pet that you have favorited" do
    pet = create(:random_pet)
    visit "/pets/#{pet.id}"
    click_button "Add #{pet.name} to Favorites"

    visit "/favorites/#{pet.id}"
    expect(page).to have_css "img[src = '#{@pet.image}']"
    expect(page).to have_content @pet.name
    expect(page).to have_content @pet.approximate_age
    expect(page).to have_content @pet.sex
    expect(page).to have_content @pet.description
  end
end