class PetsController < ApplicationController
  def index
    if params[:shelter_id]
      @shelter = Shelter.find(params[:shelter_id])
      @pets = @shelter.pets.sort_adoptable
    else
      @pets = Pet.sort_adoptable
    end
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
    Pet.destroy(params[:id])
    redirect_to "/pets"
  end

  def toggle_adoptable
    pet = Pet.find(params[:id])
    pet.toggle_adoptable
    pet.save
    redirect_to "/pets/#{pet.id}"
  end

private
  def pet_params
    params.permit(:image, :name, :description, :approximate_age, :sex)
  end
end
