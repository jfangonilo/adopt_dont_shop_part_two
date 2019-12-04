require "rails_helper"

describe "shelter edit page" do
  before :each do
    @review = create(:random_shelter_review)
    visit "shelters/#{@review.shelter_id}/shelter_reviews/#{@review.id}/edit"
  end

  it "can update a shelter" do
    title   = "test title"
    rating  = 5
    content = "test content"
    picture = "http://lorempixel.com/400/300/cats/10/"

    fill_in "title",    with: title
    fill_in "rating",   with: rating
    fill_in "content",  with: content
    fill_in "picture",  with: picture
    click_button "Update"

    expect(current_path).to eq "/shelters/#{@review.shelter.id}"
    expect(page).to have_content @review.title
    expect(page).to have_content @review.rating
    expect(page).to have_content @review.content
    expect(page).to have_css "img[src = '#{@review.picture}']"
  end
end