require 'rails_helper'

describe "As a visitor, when I visit the shelters index page," do
  before :each do
    @shelter_1 = Shelter.create!(
      name:     "Winterfell",
      address:  "6303 W Exposition Ave",
      city:     "Lakewood",
      state:    "CO",
      zip:      "80226"
    )
    @shelter_2 = Shelter.create!(
      name:     "Sunspear",
      address:  "12322 Bohannon Blvd",
      city:     "Orlando",
      state:    "FL",
      zip:      "32824"
    )

    visit "/shelters"
  end

  it "I can see the name of each shelter in the system" do
    expect(page).to have_content "Winterfell"
    expect(page).to have_content "Sunspear"
  end

  it "I can navigate to the shelter creation page via a link" do
    click_link "New Shelter"
    expect(current_path).to eq "/shelters/new"
  end

  it "I can navigate to individual shelters via a link" do
    click_link "Winterfell"
    expect(current_path).to eq "/shelters/#{@shelter_1.id}"
  end

  it "I can navigate to a specific shelter edit page" do
    within "#shelter-#{@shelter_1.id}" do
      click_link "Edit"
    end
    expect(current_path).to eq "/shelters/#{@shelter_1.id}/edit"
  end

  it "I can delete a shelter" do
    within "#shelter-#{@shelter_1.id}" do
      click_link "Delete"
    end
    expect(page).to_not have_content "Winterfell"
  end

  it "I can sort alphhabetically" do
    click_link "Sort Alphabetically"
    expect(page.body.index("Sunspear")).to be < page.body.index("Winterfell")
  end
end

