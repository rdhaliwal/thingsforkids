class Listing < ApplicationRecord
  has_one_attached :logo
  has_many_attached :images
  belongs_to :user

  scope :match_postcode, -> (lat, lng) { near([lat,lng], 99999, order: :postcode) }
  scope :match_days, -> (days) { where('days_available && array[?]', days) }

  enum activity_type: {
    'POI' => 1,
    'Classes' => 2,
    'Play Centres' => 3,
    'Childcare Centres' => 4,
    'Kid Friendly Cafes' => 5,
    'Parks & Playgrounds' => 6,
  }

  enum listing_type: {
    free:     1,
    premium:  2,
  }

  before_save :sanitize_array_input

  paginates_per 6

  WEEK_DAYS = %w(Monday Tuesday Wednesday Thursday Friday Saturday Sunday)

  geocoded_by :full_address
  after_validation :geocode, if: -> (obj){ obj.address.present? and obj.address_changed? }

  def full_address
    "#{address}, #{city}, #{state} #{postcode}"
  end

  def location
    "#{city}, #{state} #{postcode}"
  end

  def age_range
    "#{min_age} - #{max_age}"
  end

  private

  def sanitize_array_input
    self.days_available = days_available.reject { |d| d.blank? }
  end
end
