class Listing < ApplicationRecord
  paginates_per 6

  has_one_attached :logo

  has_many_attached :images

  enum activity_type: {
    classes: 1,
    parks_playground: 2,
    play_centers: 3,
    kid_cafes: 4,
    poi:       5,
    children_centers: 6,
  }

  validate :sanitize_array_input

  WEEK_DAYS = %w(Monday Tuesday Wednesday Thursday Friday Saturday Sunday)

  scope :match_zip_code, ->(zip_code) {where('zip_code = ?', zip_code)}

  def full_address
    "#{address}, #{city}, #{state} #{zip_code}".html_safe
  end


  private
    def sanitize_array_input
      self.days_available = self.days_available.drop(1)
    end
end
