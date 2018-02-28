module ListingHelper
  def render_icon listing, property
    return "fa fa-check-circle" if listing.send(property)
    'fa fa-times-circle negative'
  end
end
