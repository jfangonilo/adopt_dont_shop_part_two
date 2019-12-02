require 'rails_helper'

describe "When I visit a pet creation page," do
  before :each do
    @shelter = Shelter.create(
      name:     "Winterfell",
      address:  "6303 W Exposition Ave",
      city:     "Lakewood",
      state:    "CO",
      zip:      "80226"
    )

    visit "/shelters/#{@shelter.id}/pets/new"
  end

  it "I can fill out a form for a new pet and can see the new pet in the index" do
    fill_in 'image',            with: 'https://heavyeditorial.files.wordpress.com/2019/04/ghost.jpg'
    fill_in 'name',             with: 'Ghost'
    fill_in 'description',      with: 'Winter is Here; Direwolf'
    fill_in 'approximate_age',  with: 5
    choose  'sex',              with: 'Male'
    click_button "Submit"

    expect(current_path).to eq "/shelters/#{@shelter.id}/pets"
    expect(page).to have_css "img[src *= 'ghost.jpg']"
    expect(page).to have_content "Ghost"
    expect(page).to have_content 5
    expect(page).to have_content "Male"
  end
end
