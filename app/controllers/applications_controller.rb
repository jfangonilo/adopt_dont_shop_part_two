class ApplicationsController < ApplicationController

  def new
    @favorite_pets = favorites.contents.reduce([]) do |acc, (id, value)|
      acc << Pet.find(id)
    end
  end

    def create
      pets = Pet.find(params[:pets_applied_for])
      app = Application.new(application_params)

      if app.save || params[:pets_applied_for] == []
        pet_ids = params[:pets_applied_for]
        pet_ids.each do |pet_id|
          favorites.delete_pet(pet_id)
        end
        app.pets << pets
      else
        flash[:notice] = "Please fill out all fields!"
      end

      redirect_to '/favorites'
      messages = []
        pets.each do |pet|
          messages <<  "Application sent for #{pet.name}!"
          flash[:submit] = messages.join(' ')
        end
    end

  private

    def application_params
      params.permit(:name, :address, :city, :state, :zip, :phone_number, :description)
    end
end
