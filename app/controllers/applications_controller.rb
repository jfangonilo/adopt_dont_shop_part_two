class ApplicationsController < ApplicationController

  def new
    @favorite_pets = favorites.contents.reduce([]) do |acc, (id, value)|
      acc << Pet.find(id)
    end
  end

    def create
      app = Application.create(application_params)
      pets = Pet.find(params[:pets_applied_for])
      app.pets << pets
      redirect_to '/favorites'
      messages = []
        pets.each do |pet|
          messages <<  "Application sent for #{pet.name}!"
          flash[:submit] = messages.join(' ')
        end
      pet_ids = params[:pets_applied_for]
      pet_ids.each do |pet_id|
        favorites.delete_pet(pet_id)
      end
    end

  private

    def application_params
      params.permit(:name, :address, :city, :state, :zip, :phone_number, :description)
    end
end
