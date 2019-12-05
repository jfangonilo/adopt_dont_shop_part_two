require 'rails_helper'

RSpec.describe "When a user adds a pet to their favorites" do
  it "displays message that pet was added to favorites" do
    pet = create(:random_pet)

    visit "/pets/#{pet.id}"

    click_button "Add #{pet.name} to Favorites"

    expect(page).to have_content("#{pet.name} has been added to your favorites!")
  end
end
