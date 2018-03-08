ActiveAdmin.register User do
  permit_params :first_name, :last_name, :email

  index do
    selectable_column
    id_column
    column :email

    actions
  end

  collection_action :new_invitation do
    @user = User.new
  end

  collection_action :send_invitation, method: :post do
    result = SendUserInvite.new(permitted_params[:user], current_admin_user).call
    if result
      redirect_to admin_listings_path, notice: "Invitation sent!."
    else
      redirect_to admin_listings_path, alert: "User already exists!"
    end
  end
end
