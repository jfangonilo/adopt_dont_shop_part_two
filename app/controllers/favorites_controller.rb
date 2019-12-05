class FavoritesController < ApplicationController

  def update
    pet = Pet.find(params[:pet_id])
    favorites = Favorites.new(session[:favorites])
    favorites.add_pet(pet.id)
    # session[:favorites] ||= Hash.new(0)
    # session[:favorites][pet_id_str] ||= 1
    redirect_to "/pets/#{pet.id}"
    flash[:notice] = "#{pet.name} has been added to your favorites!"
  end
end
