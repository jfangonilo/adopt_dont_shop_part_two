class FavoritesController < ApplicationController
  def index
    if favorites.pets.empty?
      flash.now[:notice] = "How could you be so heartless??? You don't have any favorites yet!"
    else
      @pets = Pet.find(favorites.pets)
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
