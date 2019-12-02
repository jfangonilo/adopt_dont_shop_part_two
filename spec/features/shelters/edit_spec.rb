require 'rails_helper'

describe "As a visitor, when I visit /shelters/:id/edit," do
  before :each do
    @shelter_1 = Shelter.create!(
      name:     "Shelter 1",
      address:  "6303 W Exposition Ave",
      city:     "Lakewood",
      state:    "CO",
      zip:      "80226"
    )

    visit "/shelters/#{@shelter_1.id}/edit"
  end

  it "I can fill out a form to update that shelter and can see the updated information" do
    fill_in 'name',    with: 'test shelter'
    fill_in 'address', with: 'test shelter address'
    fill_in 'city',    with: 'test shelter city'
    fill_in 'state',   with: 'test shelter state'
    fill_in 'zip',     with: 'test shelter zip'

    click_button "Update"
    
    expect(current_path).to eq "/shelters/#{@shelter_1.id}"

    expect(page).to have_content "test shelter"
    expect(page).to have_content "test shelter address"
    expect(page).to have_content "test shelter city"
    expect(page).to have_content "test shelter state"
    expect(page).to have_content "test shelter zip"

    expect(page).to_not have_content "Shelter 1"
    expect(page).to_not have_content "6303 W Exposition Ave"
    expect(page).to_not have_content "Lakewood"
    expect(page).to_not have_content "CO"
    expect(page).to_not have_content "80226"
  end
end
