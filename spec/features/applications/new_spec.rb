require "rails_helper"

describe "new application" do
  it "has a link to application form from favorites" do
    pet_1 = create(:random_pet)
    pet_2 = create(:random_pet)
    pet_3 = create(:random_pet)

    visit "/pets/#{pet_1.id}"
    click_button "Add #{pet_1.name} to Favorites"
    visit "/pets/#{pet_2.id}"
    click_button "Add #{pet_2.name} to Favorites"
    visit "/pets/#{pet_3.id}"
    click_button "Add #{pet_3.name} to Favorites"

    visit "/favorites"
    click_button "Start Adoption Application"

    within "#pet-#{pet_1.name}" do
      check "pets_applied_for_"
    end
    within "#pet-#{pet_2.name}" do
      check "pets_applied_for_"
    end
    within "#pet-#{pet_3.name}" do
      uncheck "pets_applied_for_"
    end

    name          = "Jomah"
    address       = "6303 W Exposition Ave"
    city          = "Lakewood"
    state         = "CO"
    zip           = "80226"
    phone_number  = "4079274443"
    description   = "I love all animals and will give the goodest boys all the belly rubs"

    fill_in "name",         with: name
    fill_in "address",      with: address
    fill_in "city",         with: city
    fill_in "state",        with: state
    fill_in "zip",          with: zip
    fill_in "phone_number", with: phone_number
    fill_in "description",  with: description
    click_button "Submit Application"

    expect(current_path).to eq "/favorites"
    expect(page).to have_content "Application sent for #{pet_1.name}!"
    expect(page).to have_content "Application sent for #{pet_2.name}!"

    visit '/favorites'
    expect(page).to_not have_content pet_1.name
    expect(page).to_not have_content pet_2.name
    expect(page).to have_content pet_3.name
  end
end
