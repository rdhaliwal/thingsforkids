class Users::RegistrationsController < Devise::RegistrationsController
 def create
    super
    UserMailer.welcome(resource.id).deliver if resource.persisted?
  end

  protected

    def after_sign_up_path_for(resource)
      my_listings_path
    end
end
