require 'rails_helper'

describe "As a visitor, when I visit /shelters/:id/edit," do
  before :each do
    @shelter_1 = create(:random_shelter)

    visit "/shelters/#{@shelter_1.id}/edit"
  end

  it "I can fill out a form to update that shelter and can see the updated information" do
    fill_in "name",    with: "test shelter"
    fill_in "address", with: "test shelter address"
    fill_in "city",    with: "test shelter city"
    fill_in "state",   with: "test shelter state"
    fill_in "zip",     with: "test shelter zip"

    click_button "Update"

    expect(current_path).to eq "/shelters/#{@shelter_1.id}"

    expect(page).to have_content "test shelter"
    expect(page).to have_content "test shelter address"
    expect(page).to have_content "test shelter city"
    expect(page).to have_content "test shelter state"
    expect(page).to have_content "test shelter zip"

    expect(page).to_not have_content @shelter_1.name
    expect(page).to_not have_content @shelter_1.address
    expect(page).to_not have_content @shelter_1.city
    expect(page).to_not have_content @shelter_1.state
    expect(page).to_not have_content @shelter_1.zip
  end

  it "redirects to shelters/new page and displays flash message if not all fields filled in" do
    click_button "Update"

    expect(current_path).to eq("/shelters/#{@shelter_1.id}/edit")
    expect(page).to have_content("Name can't be blank")
    expect(page).to have_content("Address can't be blank")
    expect(page).to have_content("City can't be blank")
    expect(page).to have_content("State can't be blank")
    expect(page).to have_content("Zip can't be blank")
  end
end
