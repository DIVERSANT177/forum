class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  # protect_from_forgery with: :exception

  # # def after_sign_in_path_for(resource)
  # #   stored_location_for(resource) || request.referer || root_path
  # # end
end
