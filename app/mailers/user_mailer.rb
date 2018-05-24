class UserMailer < ApplicationMailer
  def user_invite invitee_id, invitation_token, inviter_id
    @user = User.find(invitee_id)
    @listing = @user.listings.first
    @inviter = AdminUser.find(inviter_id)
    @token = invitation_token
    mail(to: @user.email, subject: "New invitation")
  end

  def welcome user_id
    @user = User.find(user_id)
    mail(to: @user.email, subject: "You have successfully registered with Things For Kids")
  end
end
