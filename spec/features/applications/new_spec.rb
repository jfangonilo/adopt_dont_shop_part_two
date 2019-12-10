require "rails_helper"

describe "new application" do
  it "doesn't have a link to start adoption process if no pets have been added to favorites" do
    visit "/favorites"
    expect(page).not_to have_button "Start Adoption Application"
  end

  it "doesn't accept invalid application (no pets selected/fields missed)" do
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
    click_button "Submit Application"

    expect(current_path).to eq "/applications/new"
    expect(page).to have_content "Please fill out all fields!"
  end

  it "doesn't accept invalid application (no pets/all fields filled)" do
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

    expect(current_path).to eq "/applications/new"
    expect(page).to have_content "Please fill out all fields!"
  end

  it "doesn't accept invalid application (pets selected, but fields missed)" do
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

    click_button "Submit Application"

    expect(current_path).to eq "/applications/new"
    expect(page).to have_content "Please fill out all fields!"
  end

  it "has a link to application form from favorites (happy path)" do
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

    app = Application.last

    expect(app.pets).to eq([pet_1, pet_2])

    expect(current_path).to eq "/favorites"
    expect(page).to have_content "Application sent for #{pet_1.name}!"
    expect(page).to have_content "Application sent for #{pet_2.name}!"

    visit '/favorites'

    within "#favorites" do
      expect(page).to_not have_content pet_1.name
      expect(page).to_not have_content pet_2.name
      expect(page).to have_content pet_3.name
    end
  end
end
