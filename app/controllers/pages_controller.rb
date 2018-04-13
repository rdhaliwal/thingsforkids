class PagesController < ApplicationController
  def contact
    @message = Message.new
  end

  def mailchimp_subscription
    return redirect_to listings_path, alert: "Provide Email"  if params[:email].blank?
    notice = MailchimpService.call(params[:email])
    redirect_to listings_path, notice: notice
  end
end
