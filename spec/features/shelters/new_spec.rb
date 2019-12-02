require 'rails_helper'

describe "As a visitor, when I visit shelters/new," do
  it "I can fill out a form to create a shelter and am returned to the shelter index page" do
    visit "shelters/new"
    fill_in 'name',    with: 'test shelter'
    fill_in 'address', with: 'test shelter address'
    fill_in 'city',    with: 'test shelter city'
    fill_in 'state',   with: 'test shelter state'
    fill_in 'zip',     with: 'test shelter zip'

    click_button 'Submit'

    expect(current_path).to eq "/shelters"
    expect(page).to have_content "test shelter"
  end
end
