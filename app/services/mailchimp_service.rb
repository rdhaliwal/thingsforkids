class MailchimpService
  def self.call email
    begin
      gibbon = Gibbon::Request.new
      gibbon.lists(Rails.application.credentials.mailchimp_list_id).members.create(body: {email_address: email, status: 'subscribed'})
      "Thanks for subscribing!"
    rescue Gibbon::MailChimpError => ex
      ex.title
    end
  end
end
