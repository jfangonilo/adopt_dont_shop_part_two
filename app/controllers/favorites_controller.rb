class FavoritesController < ApplicationController

  def index
    favorite_ids = session[:favorites].keys
    @pets = favorite_ids.map(&:to_i).map{|id| Pet.find(id)}
  end

  def update
    pet = Pet.find(params[:pet_id])
    favorites.add_pet(pet.id)
    redirect_to "/pets/#{pet.id}"
    flash[:notice] = "#{pet.name} has been added to your favorites!"
  end
end
