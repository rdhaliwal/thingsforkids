class Invoice < ApplicationRecord
  belongs_to :listing

  validates :listing, :stripe_invoice_id, presence: true
  delegate :user_email, to: :listing

end
