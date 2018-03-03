module ListingHelper
  def render_icon listing, property
    return "fa fa-check-circle" if listing.send(property)
    'fa fa-times-circle negative'
  end

  def listing_form_id(type)
    return 'free_listing_form' if type == "free"
    'paid_listing_form'
  end

  def days_filter_checked?(day, params)
    params.include?(day) if params.present?
  end

  def min_age_range(params)
    return 5 unless params.present?
    params[:min_age_gteq] || 5
  end

  def max_age_range(params)
    return 10 unless params.present?
    params[:max_age_lteq] || 10
  end
end