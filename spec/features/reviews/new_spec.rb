require 'rails_helper'
RSpec.describe "As a visitor, when I visit a shelter show page" do
  it "I see a link to create a new shelter review" do
    shelter_1 = create(:random_shelter)
    visit "/shelters/#{shelter_1.id}"
    click_link "Add a Review"

    expect(current_path).to eq("/shelters/#{shelter_1.id}/reviews/new")
    expect(page).to have_content("New Review")

    review_title = "Best shelter ever!"
    review_rating = 5
    review_content = "Adopted the best puppy! Only got bit once!"
    review_picture = "https://images.unsplash.com/photo-1506917728037-b6af01a7d403?ixlib=rb-1.2.1&auto=format&fit=crop&w=1934&q=80"

    fill_in "Title", with: review_title
    select review_rating, :from => 'rating'
    fill_in "Content", with: review_content
    fill_in "Picture", with: review_picture
    click_button "Submit Review"

    expect(current_path).to eq("/shelters/#{shelter_1.id}")
    expect(page).to have_content(review_title)
    expect(page).to have_content(review_rating)
    expect(page).to have_content(review_content)
    expect(page).to have_css("img[src = '#{review_picture}']")
  end
end
