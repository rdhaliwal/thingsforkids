class Listing < ApplicationRecord
  enum activity_type: {
    classes: 1,
    parks_playeground: 2,
    play_centers: 3,
    kid_cafes: 4,
    poi:       5,
    children_centers: 6,
  }

  WEEK_DAYS = %w(Monday Tuesday Wednesday Thursday Friday Saturday Sunday)
end
