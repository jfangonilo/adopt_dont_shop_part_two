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
<<<<<<< HEAD
        messages <<  "Application sent for #{pet.name}!"
        flash[:submit] = messages.join
      end
=======
        messages << "Application sent for #{pet.name}!"
      end 
      flash[:notice] = messages.join
>>>>>>> 69b509fd125796a48e2d78bad87306f3fb27a0a6
    end
end
