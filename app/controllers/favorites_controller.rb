class FavoritesController < ApplicationController

  def update
    pet = Pet.find(params[:pet_id])
    cookies[:favorites] ||= []
    cookies[:favorites] << pet

    binding.pry
    flash[:favorited] = "#{pet.name} has been added to your favorites!"
    redirect_to "/pets/#{pet.id}"
  end
end
