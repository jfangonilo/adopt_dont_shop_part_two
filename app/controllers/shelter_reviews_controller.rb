class ShelterReviewsController < ApplicationController

  def edit
    @review = ShelterReview.find(params[:id])
  end

end