class PetsController < ApplicationController
  def index
    @pets = Pet.sort_adoptable
  end

  def show
    @pet = Pet.find(params[:id])
  end

  def new
    @shelter_id = params[:shelter_id]
  end

  def edit
    @pet = Pet.find(params[:id])
  end

  def create
    shelter = Shelter.find(params[:shelter_id])
    pet = shelter.pets.create(pet_params)
    redirect_to "/shelters/#{pet.shelter_id}/pets"
  end

  def update
    pet = Pet.find(params[:id])
    pet.update(pet_params)
    pet.save
    redirect_to "/pets/#{pet.id}"
  end

  def destroy
    pet_id = params[:id]
    favorites.delete_pets([pet_id])
    Pet.destroy(pet_id)
    redirect_to "/pets"
  end

private
  def pet_params
    params.permit(:image, :name, :description, :approximate_age, :sex)
  end
end
