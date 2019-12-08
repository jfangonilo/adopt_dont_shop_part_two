class ApplicationsController < ApplicationController

  def new
    @favorite_pets = favorites.contents.reduce([]) do |acc, (id, value)|
      acc << Pet.find(id)
    end
  end

    def create
      pets = Pet.find(params[:pets_applied_for])
      redirect_to '/favorites'
      flash[:submit] ||= []
      pets.each do |pet|
        flash[:submit] <<  "Application sent for #{pet.name}!"
      end
      flash[:submit]
    end
end
