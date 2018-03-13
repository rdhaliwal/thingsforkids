class ApplicationController < ActionController::Base

  protected
    def after_sign_in_path_for(resource)
      stored_location_for(resource) || my_listings_path
    end
end
