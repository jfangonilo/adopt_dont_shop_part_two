class PetApplicationsController < ApplicationController
  def update
    pet = Pet.find(params[:pet_id])
    pet.toggle_adoptable

    pet_app = pet.find_application(params[:application_id])
    pet_app.toggle_pending

    if pet.adoptable?
      redirect_to "/applications/#{pet_app.application_id}"
    else
      redirect_to "/pets/#{pet.id}"
    end
  end
end
