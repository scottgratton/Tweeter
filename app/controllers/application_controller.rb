class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:username, :name, :bio, :location, :avatar])
    devise_parameter_sanitizer.permit(:account_update, keys: [:username, :name, :bio, :location, :avatar])
  end

  layout 'application'
  before_action :set_layout_variables

  def set_layout_variables
    @tweet = Tweet.new
  end

end
