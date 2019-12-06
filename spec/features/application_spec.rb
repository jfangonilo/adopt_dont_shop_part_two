require 'rails_helper'

describe "All pages" do
  before :each do
    visit "/"
  end

  it "should have link to pet index" do
    click_link "Pets"
    expect(current_path).to eq "/pets"
  end

  it "should have link to shelter index" do
    click_link "Shelters"
    expect(current_path).to eq "/shelters"
  end

  it "should have link to favorites" do
    within ".topnav" do
      click_link "Favorites: 0"
    end
    expect(current_path).to eq "/favorites"
  end
end
