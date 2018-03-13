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
    return 0 unless params.present?
    params[:min_age] || 0
  end

  def max_age_range(params)
    return 10 unless params.present?
    params[:max_age] || 10
  end

  def range(params)
    "#{min_age_range(params)} - #{max_age_range(params)}"
  end

  def add_class
    return 'd-none' if controller_name == "my_listings" && action_name = "edit"
  end

  def edit_action?
    controller_name == "my_listings" && ['edit', 'update'].include?(action_name)
  end
end
