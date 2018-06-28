class StripeInvoiceEvents
  attr_reader :event
  attr_reader :listing

  def initialize(event)
    @event = event
    @listing = Listing.find_by(subscription_id: stripe_subscription)
  end

  def payment_succeeded
    return unless listing.present?
    invoice = listing.invoices.create(amount: stripe_invoice.amount_due, stripe_invoice_id: stripe_invoice.id)
    listing.update(has_paid: true)
    InvoicesMailer.dispatch_invoice(invoice.id).deliver_later
  end

  def payment_failed
    return unless listing.present?
    return downgrade_listing if stripe_next_payment_attempt.blank?
    InvoicesMailer.problem_with_payment(listing.id).deliver_later
  end

  private

    def stripe_subscription
      stripe_invoice.subscription
    end

    def stripe_next_payment_attempt
      stripe_invoice.next_payment_attempt
    end

    def stripe_invoice
      event.data.object
    end

    def downgrade_listing
      listing.update(listing_type: :free)
      InvoicesMailer.downgrade_listing(listing.id).deliver_later
    end
end
