class FavoritesController < ApplicationController

  def update
    pet = Pet.find(params[:pet_id])
    favorites = FavoriteList.new(sesion[:favorites])
    favorites.add_pet(pet.id)
    session[:favorites] = favorites.contents
    # cookies[:favorites] = ||= Hash.new(0)
    # cookies[:favorites][pet_id_str] ||= 0
    # cookies[:favorites][pet_id_str] += 1

    flash[:favorited] = "#{pet.name} has been added to your favorites!"
    redirect_to "/pets/#{pet.id}"
  end
end
