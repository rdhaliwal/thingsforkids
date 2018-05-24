class ListingsMailer < ApplicationMailer
  def free_listing(listing_id)
    @listing = Listing.find(listing_id)
    mail(to: @listing.email, subject: "You have created a Free Listing")
  end

  def premium_listing(listing_id)
    @listing = Listing.find(listing_id)
    mail(to: @listing.email, subject: "You updated to Premium Listing")
  end
end
