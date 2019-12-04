class ShelterReviewsController < ApplicationController

  def edit
    @review = ShelterReview.find(params[:shelter_review_id])
  end

end