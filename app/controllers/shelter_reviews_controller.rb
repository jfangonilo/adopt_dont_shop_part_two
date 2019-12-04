class ShelterReviewsController < ApplicationController

  def new
    @shelter_id = params[:shelter_id]
  end

  def create
    @shelter_id = params[:shelter_id]
    shelter = Shelter.find(params[:shelter_id])
    shelter_review = shelter.shelter_reviews.new(shelter_review_params)

    if shelter_review.save
      redirect_to "/shelters/#{shelter.id}"
    else
      flash.now[:notice] = "Please fill out all fields"
      render :new
    end
  end

  def edit
    @review_id = params[:shelter_review_id]
    @shelter_id = params[:shelter_id]
  end

  def update
    review = ShelterReview.find(params[:shelter_review_id])
    review.update(shelter_review_params)
    if review.save
      redirect_to "/shelters/#{review.shelter_id}"
    else
      @review_id = params[:shelter_review_id]
      @shelter_id = params[:shelter_id]
      flash.now[:notice] = "Please fill out all fields"
      render :edit
    end
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
