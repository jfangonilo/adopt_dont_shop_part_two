class FavoritesController < ApplicationController

  def index
    @pets_with_apps = Pet.find_all_with_applications

    session[:favorites] ||= Hash.new(0)
    favorite_ids = session[:favorites].keys
    @pets = favorite_ids.map(&:to_i).map{|id| Pet.find(id)}
    if @pets.empty?
      flash.now[:notice] = "How could you be so heartless??? You don't have any favorites yet!"
    end
  end

  def show
    @pet = Pet.find(params[:pet_id])
    render 'pets/show'
  end

  def update
    pet = Pet.find(params[:pet_id])
    favorites.add_pet(pet.id)
    redirect_to "/pets/#{pet.id}"
    flash[:notice] = "#{pet.name} has been added to your favorites!"
  end

  # redirect_back to just use one method and stay RESTful
  # chose '/favorites' as fallback_location for user experience
  def destroy
    pet = Pet.find(params[:pet_id])
    favorites.delete_pets([pet.id])
    redirect_back(fallback_location: '/favorites')
    flash[:notice] = "#{pet.name} has been removed from your favorites."
  end

  def reset
    session.delete(:favorites)
    redirect_to "/favorites"
  end
end
