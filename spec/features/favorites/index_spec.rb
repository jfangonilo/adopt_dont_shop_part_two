require 'rails_helper'

RSpec.describe "favorites index page" do
  it "displays all favorited pets, with name and image" do
    pet_1 = create(:random_pet)
    pet_2 = create(:random_pet)

    visit "/pets/#{pet_1.id}"
    click_button "Add #{pet_1.name} to Favorites"

    visit "/pets/#{pet_2.id}"
    click_button "Add #{pet_2.name} to Favorites"

    visit '/favorites'

    expect(page).to have_content(pet_1.name)
    expect(page).to have_css("img[src = '#{pet_1.image}']")
    expect(page).to have_content(pet_2.name)
    expect(page).to have_css("img[src = '#{pet_2.image}']")
  end

  it "shows a message if you have no pets in your favorites" do
    visit "/favorites"
    expect(page).to have_content "How could you be so heartless??? You don't have any favorites yet!"

    pet = create(:random_pet)
    visit "/pets/#{pet.id}"
    click_button "Add #{pet.name} to Favorites"

    visit "/favorites"
    expect(page).not_to have_content "How could you be so heartless??? You don't have any favorites yet!"
  end

  it "can remove all pets from favorites" do
    pet_1 = create(:random_pet)
    visit "/pets/#{pet_1.id}"
    click_button "Add #{pet_1.name} to Favorites"

    pet_2 = create(:random_pet)
    visit "/pets/#{pet_2.id}"
    click_button "Add #{pet_2.name} to Favorites"

    visit '/favorites'

    click_link "Remove All Favorites"
    expect(page).to have_content "Favorites: 0"
  end

  it "shows all pets with applications" do
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

    name = "Madelyn"
    address = "922 E. Watson Dr."
    city = "Tempe"
    state = "CO"
    zip = "80110"
    phone_number = "3032502248"
    description = "I LOVE CATS"

    fill_in "name", with: name
    fill_in "address", with: address
    fill_in "city", with: city
    fill_in "state", with: state
    fill_in "zip", with: zip
    fill_in "phone_number", with: phone_number
    fill_in "description", with: description

    click_button "Submit Application"

    visit '/favorites'
    within "#favorites-list" do
      expect(page).to have_content("All Pets with Applications")

      click_link("#{pet_1.name}")
      expect(current_path).to eq("/pets/#{pet_1.id}")
    end

    visit '/favorites'
    within "#favorites-list" do
      click_link("#{pet_2.name}")
      expect(current_path).to eq("/pets/#{pet_2.id}")
    end

    visit '/favorites'
    within "#favorites-list" do
    expect(page).not_to have_link("#{pet_3.name}")
    end
  end

  it " shows pets with approved applications" do
    pet = create(:random_pet)
    app = create(:application)
    app.pets << pet
    pet.update(adoptable: false)
    app.pet_applications.first.update(pending: true)

    visit "/favorites"
    within "#approved-applications" do
      expect(page).to have_content "Pending Approval"
      click_link pet.name
    end
    expect(current_path).to eq "/pets/#{pet.id}"
  end
end
