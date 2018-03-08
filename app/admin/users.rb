ActiveAdmin.register User do
  permit_params :first_name, :last_name, :email

  collection_action :new_invitation do
    @user = User.new
  end

  collection_action :send_invitation, method: :post do
    result = SendUserInvite.new(permitted_params[:user], current_admin_user).call
    if result
      notice = "User has been successfully invited."
    else
      notice = "User already registered on palteform."
    end
    redirect_to admin_listings_path, notice: notice
  end
end
