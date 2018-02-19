class Listing < ApplicationRecord
  paginates_per 6

  enum activity_type: {
    classes: 1,
    parks_playground: 2,
    play_centers: 3,
    kid_cafes: 4,
    poi:       5,
    children_centers: 6,
  }

  WEEK_DAYS = %w(Monday Tuesday Wednesday Thursday Friday Saturday Sunday)

  scope :match_zip_code, ->(zip_code) {where('zip_code = ?', zip_code)}
end
