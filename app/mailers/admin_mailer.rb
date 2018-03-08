class AdminMailer < ApplicationMailer
  def new_user_invite invitee_id, inviter_id
    @user = User.find(invitee_id)
    @inviter = AdminUser.find(inviter_id)
    mail(to: @inviter.email, subject: "Invitation Sent")
  end
end
