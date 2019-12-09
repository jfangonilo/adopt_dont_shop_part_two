class SheltersController < ApplicationController
  def index
    @shelters = Shelter.alpha_sort
  end

  def show
    @shelter = Shelter.find(params[:id])
  end

  def new
  end

  def create
    shelter = Shelter.new(shelter_params)
    shelter.save
    redirect_to '/shelters'
  end

  def edit
    @shelter_id = params[:id]
  end

  def update
    shelter = Shelter.find(params[:id])
    shelter.update(shelter_params)
    shelter.save
    redirect_to "/shelters/#{shelter.id}"
  end

  def destroy
    # shelter = Shelter.find(params[:id])
    # pets = Shelter.find(params[:id]).pets
    # pet_status = pets.map do |pet|
    #   pet.adoptable?
    # end
    # adoption_pending = pet_status.include?(false)
    # if adoption_pending
    #   redirect_to "/shelters/#{shelter.id}"
    #   flash[:notice] = "Cannot delete #{shelter.name}, adoptions pending."
    # elsif adoption_pending == false
      Shelter.destroy(params[:id])
      redirect_to '/shelters'
    # end
  end

private
  def shelter_params
    params.permit(:name, :address, :city, :state, :zip)
  end

end
