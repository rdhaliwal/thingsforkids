module ListingHelper
  def render_icon listing, property
    return "fa fa-check-circle" if listing.send(property)
    'fa fa-times-circle negative'
  end

  def listing_form_id(type)
    return 'free_listing_form' if type == "free"
    'paid_listing_form'
  end

  def render_logo(logo)
    return image_tag(logo, alt: "") if logo.attached?
    image_tag("logo.png", alt: "")
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
    return 'd-none' if controller_name == "my_listings" && action_name == "edit"
  end

  def edit_action?
    controller_name == "my_listings" && ['edit', 'update'].include?(action_name)
  end

  def upgrade_action?
    controller_name == "listings" && (action_name == "edit" || action_name == "update")
  end

  def get_activity_type_value activity_type
    Listing.activity_types[activity_type]
  end

  def set_banner listing_type_value
    return "POIbanner.png" if listing_type_value == 1
    return "classesbanner.png" if listing_type_value == 2
    return "playcenterbanner.png" if listing_type_value == 3
    return "childcarebanner.png" if listing_type_value == 4
    return "cafebanner.png" if listing_type_value == 5
    "parks_playgroundsbanner.png" if listing_type_value == 6 || listing_type_value == nil
  end

  def truncate_short_description description
    description.truncate(145) if description.present?
  end

  def render_image image
    image.variant(combine_options: { resize: '870x442^', gravity: 'Center', extent: '870x442', quality: 95 })
  end

  def render_url webiste_url
    return if webiste_url.blank?
    return webiste_url if webiste_url.include?('http') || webiste_url.include?('https')
    "http://#{webiste_url}"
  end
end
