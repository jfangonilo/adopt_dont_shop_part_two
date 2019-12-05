class FavoritesController < ApplicationController

  def index
    @favs = session[:favorites].keys
  end

  def update
    pet = Pet.find(params[:pet_id])
    favorites.add_pet(pet.id)
    redirect_to "/pets/#{pet.id}"
    flash[:notice] = "#{pet.name} has been added to your favorites!"
  end
end
