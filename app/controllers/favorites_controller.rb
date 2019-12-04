class FavoritesController < ApplicationController

  def update
    pet = Pet.find(params[:pet_id])
    redirect_to "/pets/#{pet.id}"
    flash[:favorited] = "#{pet.name} has been added to your favorites!"
  end

end
