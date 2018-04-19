ActiveAdmin.register User do
  permit_params :first_name, :last_name, :email

  index do
    selectable_column
    id_column
    column :email

    actions
  end

  form do |f|
    f.inputs do
      f.string :first_name
      f.string :last_name
      f.input :email
    end
    f.actions
  end

  member_action :send_invitation do
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
