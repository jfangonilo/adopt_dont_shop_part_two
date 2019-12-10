class PetApplicationsController < ApplicationController
  def update
    app_id = params[:application_id]
    pet_id = params[:pet_id]

    application = Application.find(app_id)
    pet = Pet.find(pet_id)
    pet_app = PetApplication.where(pet_id: pet_id, application_id: app_id).limit(1).first

    pet.toggle_adoptable
    pet_app.toggle_pending

    redirect_to "/pets/#{pet.id}"
  end
end