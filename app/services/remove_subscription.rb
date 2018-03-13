class RemoveSubscription
  def self.call subscription_id
    subscription = Stripe::Subscription.retrieve(subscription_id)
    if subscription.present?
      subscription.delete
    end
  end
end
