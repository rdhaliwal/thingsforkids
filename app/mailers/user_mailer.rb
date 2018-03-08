class UserMailer < ApplicationMailer
  def user_invite invitee_id, invitation_token, inviter_id
    @user = User.find(invitee_id)
    @inviter = AdminUser.find(inviter_id)
    @token = invitation_token
    mail(to: @user.email, subject: "New invitation")
  end
end
