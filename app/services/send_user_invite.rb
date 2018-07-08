class SendUserInvite
  attr_reader :user_email
  attr_reader :invitee
  attr_reader :inviter

  def initialize(email, inviter)
    @user_email = email
    @inviter = inviter
  end

  def call
    user = User.find_by(email: user_email)

    return false if user.invitation_accepted_at?

    @invitee = user
    invite_user
  end

  private

    def invite_user
      invitee.invite! { |sp| sp.skip_invitation = true }
      invitee.update_attribute(:invitation_sent_at, Time.current)
      invite_email
      true
    end

    def invite_email
      UserMailer.user_invite(invitee.id, invitee.raw_invitation_token, inviter.id).deliver!
      AdminMailer.new_user_invite(invitee.id, inviter.id).deliver!
    end
end
