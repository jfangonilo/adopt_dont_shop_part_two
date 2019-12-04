class ShelterReviewsController < ApplicationController

  def new
    @shelter_id = params[:shelter_id]
  end

  def create
    shelter = Shelter.find(params[:shelter_id])
    shelter_review = shelter.shelter_reviews.create(shelter_review_params)
    shelter_review.save

    redirect_to "/shelters/#{shelter.id}"
  end

  def edit
    @review_id = params[:shelter_review_id]
    @shelter_id = params[:shelter_id]
  end

  def update
    
  end

  def destroy
    shelter_id = params[:shelter_id]
    ShelterReview.destroy(params[:shelter_review_id])
    redirect_to "/shelters/#{shelter_id}"
  end

  private

  def shelter_review_params
    params.permit(:title, :rating, :content, :picture)
  end
end
