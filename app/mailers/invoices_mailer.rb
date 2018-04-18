class InvoicesMailer < ApplicationMailer
  def dispatch_invoice(invoice_id)
    @invoice = Invoice.find(invoice_id)
    mail(to: @invoice.user_email, subject: "Subscription invoice")
  end

  def problem_with_payment(listing_id)
    @listing = Listing.find(listing_id)
    mail(to: @listing.user_email, subject: "Problem with your Listing subscription payment")
  end

  def downgrade_listing(listing_id)
    @listing = Listing.find(listing_id)
    mail(to: @listing.user_email, subject: "Downgraded the listing from premium to free")
  end
end
