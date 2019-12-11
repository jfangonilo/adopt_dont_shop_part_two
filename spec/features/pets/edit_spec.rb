require 'rails_helper'

describe "As a visitor, when I go to /pet/:id/edit," do
  before :each do
    @pet = create(:random_pet)

    visit "/pets/#{@pet.id}/edit"
  end

  it "I can fill out a form to update the pet and get redirected to that pet's page" do
    image           = "https://heavyeditorial.files.wordpress.com/2019/04/ghost.jpg"
    name            = "Ghost"
    description     = "Winter is Here; Direwolf"
    approximate_age = 5
    sex             = "Male"

    fill_in 'image',            with: image
    fill_in 'name',             with: name
    fill_in 'description',      with: description
    fill_in 'approximate_age',  with: approximate_age
    choose  'sex',              with: sex
    click_button "Update"

    expect(current_path).to eq "/pets/#{@pet.id}"
    expect(page).to have_css "img[src = '#{image}']"
    expect(page).to have_content name
    expect(page).to have_content description
    expect(page).to have_content approximate_age
    expect(page).to have_content sex

    expect(page).not_to have_css "img[url = '#{@pet.image}']"
    expect(page).not_to have_content @pet.name
    expect(page).not_to have_content @pet.description
  end

  it "flashes error messages for fields not filled in" do
    click_button "Update"

    expect(page).to have_content "Image can't be blank"
    expect(page).to have_content "Name can't be blank"
    expect(page).to have_content "Description can't be blank"
    expect(page).to have_content "Approximate age can't be blank"
  end
end
