class PetApplicationsController < ApplicationController
  def update
    app_id = params[:application_id]
    pet_id = params[:pet_id]

    application = Application.find(app_id)
    pet = Pet.find(pet_id)
    pet_app = PetApplication.where(pet_id: pet_id, application_id: app_id).first

    pet.toggle_adoptable
    pet_app.toggle_pending

    unless pet.adoptable?
      redirect_to "/pets/#{pet.id}"
    else
      redirect_to "/applications/#{app_id}"
    end
  end
end