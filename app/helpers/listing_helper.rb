module ListingHelper
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

  def render_age_range(listing)
    "#{render_min_age(listing)} - #{render_max_age(listing)}"
  end

  def render_min_age(listing)
    return 0 unless listing.present?
    listing.min_age || 0
  end

  def render_max_age(listing)
    return 10 unless listing.present?
    listing.max_age || 10
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

  def truncate_short_description listing
    description = listing.description || listing.short_description
    description.truncate(145) if description.present?
  end

  def render_image image
    return unless image.variable?
    image.variant(combine_options: { resize: '870x442^', gravity: 'Center', extent: '870x442', quality: 95 })
  end

  def render_url webiste_url
    return if webiste_url.blank?
    return webiste_url if webiste_url.include?('http') || webiste_url.include?('https')
    "http://#{webiste_url}"
  end

  def render_day(day)
    {
      'Monday' => 'Mon',
      'Tuesday' => 'Tue',
      'Wednesday' => 'Wed',
      'Thursday' => 'Thu',
      'Friday' => 'Fri',
      'Saturday' => 'Sat',
      'Sunday' => 'Sun',
    }[day]
  end

  def description_max_words(type)
    return '400' if type == 'premium'
    '50'
  end

  def render_city(listing)
    listing.city || 'Melbourne'
  end

  def render_state(listing)
    listing.state || 'VIC'
  end

  def render_day_error_message(listing)
    return unless listing.present?
    return unless listing.errors.any?
    "<div class='invalid-feedback'>No day is selected in available days</div>".html_safe if listing.errors[:days_available].present?
  end

  def listings_list(listings)
    tag.div class: "listings-list", data: { listings: listings.to_json(methods: [:full_address]), l: params[:l], ids: listings.pluck(:id) }
  end

  def listing_json(listing)
    tag.div class: "listings-list", data: { listings: listing.to_json(methods: [:full_address]), l: params[:l], ids: listing.id }
  end

  def render_coordinates(listing)
    [listing.latitude, listing.longitude]
  end
end
