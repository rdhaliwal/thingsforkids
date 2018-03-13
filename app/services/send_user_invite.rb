class SendUserInvite
  attr_reader :params
  attr_reader :invitee
  attr_reader :inviter

  def initialize(params, inviter)
    @params = params
    @inviter = inviter
  end

  def call
    user = User.find_by(email: params[:email])

    if user.present?
      @invitee = user
      invite_existing_user
    else
      invite_new_user
    end
  end

  private

    def invite_new_user
      @invitee = User.invite!(params) { |user| user.skip_invitation = true }
      invitee.update_attribute(:invitation_sent_at, Time.current)
      invite_email
      true
    end

    def invite_existing_user
      return false if invitee.invitation_accepted_at.present?
      invitee.invite! { |sp| sp.skip_invitation = true }
      invitee.update_attribute(:invitation_sent_at, Time.current)
      invite_email
      true
    end

    def invite_email
      UserMailer.user_invite(invitee.id, invitee.raw_invitation_token, inviter.id).deliver_later
      AdminMailer.new_user_invite(invitee.id, inviter.id).deliver_later
    end
end
