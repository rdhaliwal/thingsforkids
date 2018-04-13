class Listing < ApplicationRecord
  has_one_attached :logo
  has_many_attached :images
  belongs_to :user

  has_one :invoice

  validates :status, presence: true, if: :created_by_admin?
  validates :email, :short_description, :description, :business_name, :manager_name, :manager_job_title, :website,
            :activity_type, :phone, :logo, :address, :city, :state, :postcode, :min_age, :max_age, presence: :true, if: [:active_or_basic_info?, :validate?]
  validates :days_available, presence: :true, if: [:active_or_amenities?, :validate?]

  validate  :description_length, if: [:active_or_basic_info?, :validate?]
  validate  :short_description_length,  if: [:active_or_basic_info?, :validate?]

  scope :match_postcode, -> (lat, lng) { near([lat,lng], 99999, order: :postcode) }
  scope :match_days, -> (days) { where('days_available && array[?]', days) }
  scope :match_age, -> (min_age, max_age) { where('min_age <= ? AND max_age >= ?', max_age, min_age) }
  geocoded_by :full_address
  after_validation :geocode, if: -> (obj){ obj.address.present? and obj.address_changed? }
  after_validation :validate_address, if: [:active_or_basic_info?, :validate?]

  before_save :sanitize_array_input

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

  paginates_per 6

  WEEK_DAYS = %w(Monday Tuesday Wednesday Thursday Friday Saturday Sunday)

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

  private

  def sanitize_array_input
    self.days_available = days_available.reject { |d| d.blank? }
  end

  def active?
    status == 'active'
  end

  def active_or_basic_info?
    return unless status
    status.include?('basic') || active?
  end

  def active_or_amenities?
    return unless status
    status.include?('amenities') || active?
  end

  def validate?
    return true unless self.new_record?
    return true if self.created_by_admin?
    false
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
end
