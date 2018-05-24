ActiveAdmin.register User do
  permit_params :first_name, :last_name, :email, :password, :password_confirmation

  index do
    selectable_column
    id_column
    column :email

    actions
  end

  form do |f|
    f.inputs do
      f.input :first_name
      f.input :last_name
      f.input :email
      f.input :password
      f.input :password_confirmation
    end
    f.actions
  end

  member_action :send_invitation do
    if resource.listings.blank?
      return redirect_to admin_users_path, alert: "User doesn't have any listings."
    end
    result = SendUserInvite.new(resource.email, current_admin_user).call
    if result
      redirect_to admin_users_path, notice: "Invitation sent!."
    else
      redirect_to admin_users_path, alert: "User already exists!"
    end
  end

  action_item :new_invitation, only: [:show] do
    link_to 'Invite User', send_invitation_admin_user_path
  end
end
