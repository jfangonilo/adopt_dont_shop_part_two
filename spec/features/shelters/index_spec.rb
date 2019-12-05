require 'rails_helper'

describe "As a visitor, when I visit the shelters index page," do
  before :each do
    @shelter_1 = create(:random_shelter, name: "Winterfell")
    @shelter_2 = create(:random_shelter, name: "Sunspear")

    visit "/shelters"
  end

  it "I can see the name of each shelter in the system" do
    expect(page).to have_content "#{@shelter_1.name}"
    expect(page).to have_content "#{@shelter_2.name}"
  end

  it "I can navigate to the shelter creation page via a link" do
    click_link "New Shelter"
    expect(current_path).to eq "/shelters/new"
  end

  it "I can navigate to individual shelters via a link" do
    click_link "#{@shelter_1.name}"
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

  it "I can sort alphabetically" do
    expect(page.body.index("Sunspear")).to be < page.body.index("Winterfell")
  end
end

