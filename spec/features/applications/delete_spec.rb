require "rails_helper"

describe "pets can't be deleted if they have an approved application;" do
  it "page shows a flash message if pet is attempted to be deleted" do
    pet = create(:random_pet)
    app = create(:application)
    app.pets << pet
    pet.update(adoptable: false)
    app.pet_applications.first.update(pending: true)

    visit "/pets/#{pet.id}"
    click_link "Delete"
    expect(current_path).to eq "/pets/#{pet.id}"
    expect(page).to have_content "Approved application pending. Cannot delete #{pet.name}"
  end
end