require "rails_helper"

describe "applications show page" do
  it "allows me to approve multiple applications" do
    pets = create_list(:random_pet, 2)
    app = create(:application)
    app.pets << pets

    visit "/applications/#{app.id}"
    within "#pet-#{pets[0].id}" do
      click_link "Approve Application"
    end

    visit "/applications/#{app.id}"
    within "#pet-#{pets[1].id}" do
      click_link "Approve Application"
    end
  end

  it "allows you to approve a pet's application" do
    pet_1 = create(:random_pet)
    pet_2 = create(:random_pet)

    application = create(:application)
    application.pets << [pet_1, pet_2]

    application_2 = create(:application)
    application_2.pets << [pet_1, pet_2]

    visit "/applications/#{application_2.id}"
    within "#pet-#{pet_2.id}" do
      click_link "Approve Application"
    end

    expect(current_path).to eq "/pets/#{pet_2.id}"
    within "#adoptable-status" do
      expect(page).to have_content "Adoption Pending: #{application_2.name}"
    end
  end

  it "shows the application and the names of pets (links) applied for" do
    pet_1 = create(:random_pet)
    pet_2 = create(:random_pet)
    pet_3 = create(:random_pet)

    application = create(:application)
    application.pets << [pet_1, pet_2, pet_3]

    visit "/applications/#{application.id}"
    expect(page).to have_content application.name
    expect(page).to have_content application.address
    expect(page).to have_content application.city
    expect(page).to have_content application.state
    expect(page).to have_content application.zip
    expect(page).to have_content application.phone_number
    expect(page).to have_content application.description
    expect(page).to have_content pet_1.name
    expect(page).to have_content pet_2.name
    expect(page).to have_content pet_3.name

    click_link pet_1.name
    expect(current_path).to eq "/pets/#{pet_1.id}"
  end

  it "does not allow more than one approved application per pet and shows flash message that already approved" do
    pet_1 = create(:random_pet)
    pet_2 = create(:random_pet)

    application_1 = create(:application)
    application_2 = create(:application)

    application_1.pets << pet_1
    application_2.pets << [pet_1, pet_2]

    visit "/applications/#{application_1.id}"
    within "#pet-#{pet_1.id}" do
      click_link "Approve Application"
    end

    visit "/applications/#{application_2.id}"

    within "#pet-#{pet_1.id}" do
      expect(page).not_to have_link("Approve Application")
      expect(page).to have_content("#{pet_1.name} is already pending adoption! No more adoption approvals can be made at this time.")
    end

    within "#pet-#{pet_2.id}" do
      expect(page).to have_link("Approve Application")
    end
  end

  it "does not display already approved message on application for which approved" do
    pet_1 = create(:random_pet)
    pet_2 = create(:random_pet)
    application_1 = create(:application)
    application_2 = create(:application)

    application_1.pets << pet_1
    application_2.pets << [pet_1, pet_2]

    visit "/applications/#{application_1.id}"
    within "#pet-#{pet_1.id}" do
      click_link "Approve Application"
    end

    visit "/applications/#{application_1.id}"

    expect(page).to have_content("You are already approved!")
    expect(page).not_to have_content("#{pet_1.name} is already pending adoption! No more adoption approvals can be made at this time.")
  end

  it "allows you to revoke an approved application" do
    pet = create(:random_pet)
    app = create(:application)
    app.pets << pet

    visit "/applications/#{app.id}"
    click_link "Approve Application"

    within "#adoptable-status" do
      expect(page).to have_content "Adoption Pending"
    end

    visit "/applications/#{app.id}"
    click_link "Revoke Application"

    expect(current_path).to eq "/applications/#{app.id}"
    expect(page).to have_link "Approve Application"

    visit "/pets/#{pet.id}"
    within "#adoptable-status" do
      expect(page).to have_content "Adoptable"
    end

    visit "/applications/#{app.id}"
    click_link "Approve Application"

    within "#adoptable-status" do
      expect(page).to have_content "Adoption Pending"
    end
  end
end
