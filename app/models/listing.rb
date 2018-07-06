class Listing < ApplicationRecord
  has_one_attached :logo
  has_many_attached :images
  belongs_to :user
  has_many :invoices

  searchkick locations: [:location]

  validates :status, presence: true, if: :created_by_admin?
  validates :email, :business_name, :manager_name, :manager_job_title, :website,
            :activity_type, :phone, :address, :city, :state, :postcode, :min_age, :max_age, presence: :true, if: [:active_or_basic_info?, :validate?]
  validates :days_available, presence: :true, if: [:active_or_amenities?, :validate?]

  validates :description, presence: true, if: [:active_or_basic_info?, :validate?, :premium?]
  validates :short_description, presence: true, if: [:active_or_basic_info?, :validate?, :free?]

  validate  :description_length, if: [:active_or_basic_info?, :validate?, :premium?]
  validate  :short_description_length,  if: [:active_or_basic_info?, :validate?, :free?]

  geocoded_by :full_address
  after_validation :geocode, if: -> (obj){ obj.address.present? and obj.address_changed? }
  after_validation :validate_address, if: [:active_or_basic_info?, :validate?]

  before_save   :sanitize_array_input
  after_destroy :reindex_listing

  delegate :email, to: :user, prefix: true

  enum activity_type: {
    'POI' => 1,
    'Classes' => 2,
    'Play Centres' => 3,
    'Childcare Centres' => 4,
    'Kid Friendly Cafes' => 5,
    'Parks & Playgrounds' => 6,
  }

  enum status: {
    active:    1,
    basic:     2,
    amenities: 3,
    images:    4,
    price:     5
  }

  enum listing_type: {
    free:     1,
    premium:  2,
  }

  AMENITIES = {
    indoors: 'indoors',
    outdoors: 'Outdoors',
    parties: 'Parties',
    disability_access: 'Disability Access',
    parking: 'Parking',
    undercover: 'Undercover',
    bbq: 'BBQ',
    toilets: 'Toilets',
    highchairs: 'Highchairs',
    baby_change_room: 'Baby Change Room',
  }

  paginates_per 6

  WEEK_DAYS = %w(Monday Tuesday Wednesday Thursday Friday Saturday Sunday)

  def search_data
    attributes.merge(
      location: { lat: latitude, lon: longitude }
    )
  end

  def full_address
    "#{address}, #{city}, #{state} #{postcode}"
  end

  def location
    "#{city}, #{state} #{postcode}"
  end

  def age_range
    "#{min_age} - #{max_age}"
  end

  def description_length
    number_of_words = self.description.split(' ').length
    return errors.add(:description, ": Description must be under 50 words") if number_of_words > 50 && self.free?
    errors.add(:description, "Description must be under 400 words") if number_of_words > 400 && self.premium?
  end

  def owner? current_user
    user == current_user
  end

  def description_text
    premium? ? description : short_description
  end

  private

  def sanitize_array_input
    self.days_available = days_available.reject { |d| d.blank? }
  end

  def active_or_basic_info?
    return unless status
    basic? || active?
  end

  def active_or_amenities?
    return unless status
    amenities? || active?
  end

  def validate?
    persisted? || created_by_admin?
  end

  def validate_address
    if latitude.blank? || longitude.blank?
      self.errors.add(:address, "is not valid")
    end
  end

  def short_description_length
    number_of_words = self.short_description.split(' ').length
    errors.add(:short_description, "Short description must be under 20 words") if number_of_words > 20
  end

  def reindex_listing
    Listing.reindex
  end
end
