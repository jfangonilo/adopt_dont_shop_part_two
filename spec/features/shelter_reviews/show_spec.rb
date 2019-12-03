require "rails_helper"

describe "shelter review index" do
  before :each do
    @shelter_1 = create(:random_shelter)
    @reviews  = create_list(:random_shelter_review, 3, shelter: @shelter_1)

    visit "/shelters/#{@shelter_1.id}"
  end

  it "shows the review's traits" do
    # save_and_open_page
    # binding.pry
    @reviews.each do |review|
      within "#review-#{review.id}" do
        expect(page).to have_content review.title
        expect(page).to have_content review.rating
        expect(page).to have_content review.content
        expect(page).to have_css "img[src = '#{review.picture}']"
      end
    end
  end

end

