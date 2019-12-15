class ReviewsController < ApplicationController
  def new
    @shelter_id = params[:shelter_id]
  end

  def create
    @shelter_id = params[:shelter_id]
    shelter = Shelter.find(params[:shelter_id])
    review = shelter.reviews.new(review_params)
    if review.save
      redirect_to "/shelters/#{shelter.id}"
    else
      flash.now[:notice] = "Please fill out all fields"
      render :new
    end
  end

  def edit
    @review = Review.find(params[:id])
  end

  def update
    review = Review.find(params[:id])
    if review.update(review_params)
      redirect_to "/shelters/#{review.shelter_id}"
    else
      @review = Review.find(params[:id])
      flash.now[:notice] = "Please fill out all fields"
      render :edit
    end
  end

  def destroy
    shelter_id = params[:shelter_id]
    Review.destroy(params[:id])
    redirect_to "/shelters/#{shelter_id}"
  end

  private
    def review_params
      params.permit(:title, :rating, :content, :picture)
    end
end
