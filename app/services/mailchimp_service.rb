class MailchimpService
  def self.call email
    begin
      gibbon = Gibbon::Request.new
      gibbon.lists(ENV["MAILCHIMP_LIST_ID"]).members.create(body: {email_address: email, status: 'subscribed'})
      "Thanks. We'll notify you."
    rescue Gibbon::MailChimpError => ex
      ex.title
    end
  end
end
