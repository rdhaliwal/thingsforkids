class ListingsMailer < ApplicationMailer
  def free_listing(listing_id)
    @listing = Listing.find(listing_id)
    mail(to: @listing.email, subject: "Thank you for creating a listing on things for kids.")
  end

  def premium_listing(listing_id)
    @listing = Listing.find(listing_id)
    mail(to: @listing.email, subject: "Thank you for upgrading your listing on things for kids.")
  end
end
