class AddCreditCard
  attr_reader :user
  attr_reader :token

  def initialize(user, token)
    @user = user
    @token = token
  end

  def self.call!(user, token)
    return self.new(user, token).call!
  end

  def call!
    begin
      if user.stripe_customer_id.present?
        customer = Stripe::Customer.retrieve(user.stripe_customer_id)
        card = customer.sources.create(source: token)
      else
        customer = Stripe::Customer.create(email: user.email, card: token)
        card = customer.sources.first
        user.update_attribute(:stripe_customer_id, customer.id)
      end
      return true, card.id
    end
  rescue Stripe::CardError, Stripe::InvalidRequestError, Stripe::APIError => e
    return false, "There was an error processing your credit card: #{e.to_s}"
  end
end
