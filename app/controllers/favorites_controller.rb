class FavoritesController < ApplicationController

  def update
    pet_id = params[:pet_id]
    redirect_to "/pets/#{pet_id}"
  end
end
