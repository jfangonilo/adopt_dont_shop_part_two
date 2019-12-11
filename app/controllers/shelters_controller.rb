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
    if shelter.save
      redirect_to '/shelters'
    else
      redirect_to '/shelters/new'
    end
    flash[:error] = shelter.errors.full_messages.to_sentence
  end

  def edit
    @shelter_id = params[:id]
  end

  def update
    shelter = Shelter.find(params[:id])
    shelter.update(shelter_params)
    if shelter.save
      redirect_to "/shelters/#{shelter.id}"
    else
      redirect_to "/shelters/#{shelter.id}/edit"
    end
    flash[:error] = shelter.errors.full_messages.to_sentence
  end

  def destroy
      Shelter.destroy(params[:id])
      redirect_to '/shelters'
  end

private
  def shelter_params
    params.permit(:name, :address, :city, :state, :zip)
  end

end
