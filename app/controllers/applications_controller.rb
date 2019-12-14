class ApplicationsController < ApplicationController
  before_action :require_pets, only: [:create]

  def new
    @favorite_pets = Pet.find(favorites.contents)
  end

  def create
    pet_ids = params[:pets_applied_for]
    pets = Pet.find(pet_ids)
    app = Application.new(application_params)
    if app.save
      favorites.delete_pets(pet_ids)
      app.pets << pets
      messages = pets.map { |pet| "Application sent for #{pet.name}!" }
      redirect_to '/favorites'
      flash[:notice] = messages.join(' ')
    else
      redirect_to "/applications/new"
      flash[:notice] = "Please fill out all fields!"
    end
  end

  def index
    pet = Pet.find(params[:pet_id])
    @applications = pet.applications
    if @applications.empty?
      flash.now[:notice] = "Show this one some love! No one has applied yet!"
    end
  end

  def show
    @application = Application.find(params[:id])
  end

  private
    def application_params
      params.permit(:name, :address, :city, :state, :zip, :phone_number, :description)
    end

    def require_pets
      if !params[:pets_applied_for]
        flash[:notice] = "Please fill out all fields!"
        redirect_to "/applications/new"
      end
    end
end
