class ApplicationsController < ApplicationController
  before_action :require_pets, only: [:create]

  def new
    @favorite_pets = favorites.contents.reduce([]) do |acc, (id, value)|
      acc << Pet.find(id)
    end
  end

  def create
    pet_ids = params[:pets_applied_for]
    pets = Pet.find(pet_ids)
    app = Application.new(application_params)

    if app.save
      favorites.delete_pets(pet_ids)
      app.pets << pets
      redirect_to '/favorites'
      messages = []
      pets.each do |pet|
        messages <<  "Application sent for #{pet.name}!"
        flash[:submit] = messages.join(' ')
      end
    else
      flash[:notice] = "Please fill out all fields!"
      redirect_to "/applications/new"
    end
  end

private
  def application_params
    params.permit(:name, :address, :city, :state, :zip, :phone_number, :description)
  end

  def require_pets
    if params[:pets_applied_for].nil?
      flash[:notice] = "Please fill out all fields!"
      redirect_to "/applications/new"
    end
  end
end
