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
    select rating,    :from => 'rating'
    fill_in "content",  with: content
    fill_in "picture",  with: picture
    click_button "Update"

    expect(current_path).to eq "/shelters/#{@review.shelter.id}"

    expect(page).to have_content title
    expect(page).to have_content content
    expect(page).to have_css "img[src = '#{picture}']"

    expect(page).not_to have_content @review.title
    expect(page).not_to have_content @review.content
    expect(page).not_to have_css "img[src = '#{@review.picture}']"
  end

  it "flashes a message when user doesn't fill out a field" do
    click_button "Update"

    expect(page).to have_content "Please fill out all fields"
    expect(page).to have_button "Update"

    click_button "Update"
    expect(page).to have_content "Please fill out all fields"
    expect(page).to have_button "Update"
  end
end