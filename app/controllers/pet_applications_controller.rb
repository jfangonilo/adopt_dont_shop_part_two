class PetApplicationsController < ApplicationController
  def update
    pet_id = params[:pet_id]
    app_id = params[:application_id]
    pet = Pet.find(pet_id)
    pet.toggle_adoptable
    pet_app = pet.find_application(app_id)
    pet_app.toggle_pending
    if pet.adoptable?
      redirect_to "/applications/#{app_id}"
    else
      redirect_to "/pets/#{pet_id}"
    end
  end
end
