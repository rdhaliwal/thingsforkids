class Listing < ApplicationRecord
  has_one_attached :logo
  has_many_attached :images

  scope :match_zip_code, -> (zip_code) { where(zip_code: zip_code) }
  scope :match_days, -> (days) { where('days_available && array[?]', days) }

  enum activity_type: {
    'POI' => 1,
    'Classes' => 2,
    'Play Centres' => 3,
    'Childcare Centres' => 4,
    'Kid Friendly Cafes' => 5,
    'Parks & Playgrounds' => 6,
  }

  before_save :sanitize_array_input

  paginates_per 6

  WEEK_DAYS = %w(Monday Tuesday Wednesday Thursday Friday Saturday Sunday)

  def full_address
    "#{address}, #{city}, #{state} #{zip_code}"
  end

  private

  def sanitize_array_input
    self.days_available = days_available.reject { |d| d.blank? }
  end

  def age_range
    "#{min_age} - #{max_age}"
  end
end
