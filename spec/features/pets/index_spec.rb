require 'rails_helper'

describe "As a user, when I visit the pet index page," do
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

    @pet_1 = @shelter_1.pets.create!(
      image:            "https://www.allthingsdogs.com/wp-content/uploads/2018/12/Husky-Names-Feature.jpg",
      name:             "Seamus",
      approximate_age:  8,
      sex:              "male",
      description:      "Winter is Coming; dog"
    )
    @pet_2 = @shelter_2.pets.create!(
      image:            "https://s3.amazonaws.com/cdn-origin-etr.akc.org/wp-content/uploads/2017/11/12234710/Chihuahua-On-White-03.jpg",
      name:             "Pepper",
      approximate_age:  4,
      sex:              "female",
      description:      "Unbowed, Unbent, Unbroken; dog"
    )

    visit "/pets"
  end

  it "I can see all pets and their image, name, age, sex, name of shelter" do
    within "#pet-#{@pet_1.id}" do
      expect(page).to have_css "img[src *= 'Husky-Names-Feature.jpg']"
      expect(page).to have_content "Seamus"
      expect(page).to have_content 8
      expect(page).to have_content "male"
      expect(page).to have_content "Winterfell"
    end

    within "#pet-#{@pet_2.id}" do
      expect(page).to have_css "img[src *= 'Chihuahua-On-White-03.jpg']"
      expect(page).to have_content "Pepper"
      expect(page).to have_content 4
      expect(page).to have_content "female"
      expect(page).to have_content "Sunspear"
    end
  end

  it "I can navigate to pet update page" do
    within "#pet-#{@pet_1.id}" do
      click_link "Update"
    end
    expect(current_path).to eq "/pets/#{@pet_1.id}/edit"
  end

  it "I can delete a pet" do
    within "#pet-#{@pet_1.id}" do
      click_link "Delete"
    end
    expect(current_path).to_not have_content "Seamus"
  end

  it "I can navigate to a shelter on the page" do
    within "#pet-#{@pet_1.id}" do
      click_link "#{@pet_1.shelter_name}"
    end
    expect(current_path).to eq "/shelters/#{@pet_1.shelter_id}"
  end

  it "can navigate to a pet on the page" do
    within "#pet-#{@pet_1.id}" do
      click_link "#{@pet_1.name}"
    end
    expect(current_path).to eq "/pets/#{@pet_1.id}"
  end

  it "I can see the pets by adoptable status" do
    expect(page.body.index("Seamus")).to be < page.body.index("Pepper")
    visit "/pets/#{@pet_1.id}"
    click_link "Change to Adoption Pending"
    visit "/pets"
    expect(page.body.index("Pepper")).to be < page.body.index("Seamus")
  end
end
