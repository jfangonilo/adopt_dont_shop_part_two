class FavoritesController < ApplicationController

  def index
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

  def reset
    reset_session
    redirect_to "/favorites"
  end
end
