Rails.configuration.stripe = {
  publishable_key: ENV['STRIPE_PUBLISHABLE_KEY'],
  secret_key: ENV['STRIPE_SECRET_KEY']
}
Stripe.api_key = Rails.configuration.stripe[:secret_key]
STRIPE_PUBLIC_KEY = ENV['STRIPE_PUBLISHABLE_KEY']
StripeEvent.signing_secret = ENV['STRIPE_SIGNING_SECRET']

StripeEvent.configure do |events|
  events.subscribe 'invoice.payment_succeeded' do |event|
    StripeInvoiceEvents.new(event).payment_succeeded
  end

  events.subscribe 'invoice.payment_failed' do |event|
    StripeInvoiceEvents.new(event).payment_failed
  end
end
