class FavoritesController < ApplicationController

  def index
    favorite_ids = session[:favorites].keys
    favorite_ids.map(&:to_i)
    @pets = favorite_ids.map do |pet_id|
      Pet.find(pet_id)
    end
  end

  def update
    pet = Pet.find(params[:pet_id])
    favorites.add_pet(pet.id)
    redirect_to "/pets/#{pet.id}"
    flash[:notice] = "#{pet.name} has been added to your favorites!"
  end
end
