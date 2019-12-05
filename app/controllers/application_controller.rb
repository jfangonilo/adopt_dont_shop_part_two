class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
end

helper_method :favorites

def favorites
  @favorites ||= FavoriteList.new(session[:favorites])
end
