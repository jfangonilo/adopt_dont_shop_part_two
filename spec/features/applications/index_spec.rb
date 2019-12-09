require "rails_helper"

describe "application index page" do
  it "shows each application" do
    pet = create(:random_pet)
    application_1 = create(:application)
    application_1.pets << pet
    application_2 = create(:application)
    application_2.pets << pet
    application_3 = create(:application)
    application_3.pets << pet
    
    visit "pets/#{pet.id}"
    click_link "See Applications"
    expect(current_path).to eq "/pets/#{pet.id}/applications"

    within "#application-#{application_1.id}" do
      expect(page).to have_link application_1.name
    end
    within "#application-#{application_2.id}" do
      expect(page).to have_link application_2.name
    end
    within "#application-#{application_3.id}" do
      expect(page).to have_link application_3.name
    end

    # click_link application_1.name
    # expect(current_path).to eq "applications/#{application_1.id}"
  end
end