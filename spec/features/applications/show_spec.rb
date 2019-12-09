require "rails_helper"

describe "applications show page" do
  it "allows you to approve a pet's application" do
    pet_1 = create(:random_pet)
    pet_2 = create(:random_pet)
    application = create(:application)
    application.pets << [pet_1, pet_2]

    visit "/applications/#{application.id}"
    within "#pet-#{pet_1.id}" do
      click_link "Approve Application for #{pet_1.name}"  
    end

    expect(current_path).to eq "/pets/#{pet_1.id}"
    within "#adoptable-status" do
      expect(page).to have_content "Adoption Pending: #{application.name}"
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
end