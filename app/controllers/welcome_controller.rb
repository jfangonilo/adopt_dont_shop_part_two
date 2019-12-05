class WelcomeController < ApplicationController
  def index
    favorites = FavoriteList.new(session[:favorites])
  end
end
