class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  helper_method :favorites,
                :all_pets_with_applications,
                :all_pets_with_pending_applications

  def favorites
    @favorites = Favorites.new(session[:favorites] ||= [])
  end

  def all_pets_with_applications
    Pet.all_with_applications
  end

  def all_pets_with_pending_applications
    Pet.all_with_pending_application
  end
end
