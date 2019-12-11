require 'rails_helper'

describe "When I visit a pet creation page," do
  before :each do
    @shelter = create(:random_shelter)

    visit "/shelters/#{@shelter.id}/pets/new"
  end

  it "I can fill out a form for a new pet and can see the new pet in the index" do
    image             = "https://heavyeditorial.files.wordpress.com/2019/04/ghost.jpg"
    name              = "Ghost"
    description       = "Winter is Here, Direwolf"
    approximate_age   = 5
    sex               = "Male"

    fill_in 'image',            with: image
    fill_in 'name',             with: name
    fill_in 'description',      with: description
    fill_in 'approximate_age',  with: approximate_age
    choose  'sex',              with: sex
    click_button "Submit"

    expect(current_path).to eq "/shelters/#{@shelter.id}/pets"
    expect(page).to have_css "img[src *= '#{image}']"
    expect(page).to have_content name
    expect(page).to have_content approximate_age
    expect(page).to have_content sex
  end

  it "flashes error messages for fields not filled in" do
    click_button "Submit"

    expect(page).to have_content "Image can't be blank"
    expect(page).to have_content "Name can't be blank"
    expect(page).to have_content "Description can't be blank"
    expect(page).to have_content "Approximate age can't be blank"
    expect(page).to have_content "Sex can't be blank"
  end
end
