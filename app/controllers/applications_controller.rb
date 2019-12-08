class ApplicationsController < ApplicationController

  def new
    @favorite_pets = favorites.contents.reduce([]) do |acc, (id, value)|
      acc << Pet.find(id)
    end
  end

    def create
      pets = Pet.find(params[:pets_applied_for])
      redirect_to '/favorites'
      messages = []
      pets.each do |pet|
        messages <<  "Application sent for #{pet.name}!"
        flash[:submit] = messages.join(' ')
      end

    end
end
