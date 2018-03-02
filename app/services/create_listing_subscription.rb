class CreateListingSubscription
  attr_reader :listing
  attr_reader :card
  attr_reader :customer
  attr_reader :user

  def self.call(user, listing, card)
    self.new(user, listing, card).call
  end

  def initialize(user, listing, card)
    @user = user
    @card = card
    @customer = Stripe::Customer.retrieve(user.stripe_customer_id)
    @listing = listing
  end

  def call
    return unless card.present?
    ActiveRecord::Base.transaction do
      customer.default_source = card
      customer.save
      subscription = customer.subscriptions.create(plan: 'listing_annual')
      listing.update_attribute(:subscription_id, subscription.id)
      listing.update_attribute(:has_paid, true)
    end
  end
end
