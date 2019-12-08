class WelcomeController < ApplicationController
  def index
    favorites = Favorites.new(session[:favorites])
  end
end
