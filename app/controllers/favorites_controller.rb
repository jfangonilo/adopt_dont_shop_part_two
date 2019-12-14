class FavoritesController < ApplicationController
  def index
    @pets_with_apps = Pet.find_all_with_applications
    session[:favorites] ||= []
    favorite_ids = session[:favorites]
    @pets = Pet.find(favorite_ids)
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
    if favorites.is_included?(pet.id)
      favorites.delete_pets([pet.id])
      redirect_back(fallback_location: '/favorites')
      flash[:notice] = "#{pet.name} has been removed from your favorites."
    else
      favorites.add_pet(pet.id)
      redirect_to "/pets/#{pet.id}"
      flash[:notice] = "#{pet.name} has been added to your favorites!"
    end
  end

  def destroy
    session.delete(:favorites)
    redirect_to "/favorites"
  end
end
