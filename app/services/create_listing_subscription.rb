class CreateListingSubscription
  attr_reader :listing
  attr_reader :card
  attr_reader :customer
  attr_reader :user
  attr_reader :coupon

  def self.call(user, listing, card, coupon)
    self.new(user, listing, card, coupon).call
  end

  def initialize(user, listing, card, coupon)
    @user = user
    @card = card
    @coupon = coupon
    @customer = Stripe::Customer.retrieve(user.stripe_customer_id)
    @listing = listing
  end

  def call
    return unless card.present?
    ActiveRecord::Base.transaction do
      customer.default_source = card
      customer.save
      subscription = customer.subscriptions.create(plan: 'listing_annual', coupon: coupon)
      listing.update_attribute(:subscription_id, subscription.id)
    end
  end
end
