Rails.configuration.stripe = {
  publishable_key: Rails.application.credentials.stripe_publishable_key,
  secret_key: Rails.application.credentials.stripe_secret_key
}
Stripe.api_key = Rails.configuration.stripe[:secret_key]
STRIPE_PUBLIC_KEY = Rails.application.credentials.stripe_publishable_key
StripeEvent.signing_secret = Rails.application.credentials.stripe_signing_secret

StripeEvent.configure do |events|
  events.subscribe 'invoice.payment_succeeded' do |event|
    StripeInvoiceEvents.new(event).payment_succeeded
  end

  events.subscribe 'invoice.payment_failed' do |event|
    StripeInvoiceEvents.new(event).payment_failed
  end
end
