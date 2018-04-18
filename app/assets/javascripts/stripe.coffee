jQuery ->
  payment.setupForm()

payment =
  setupForm: ->
    $('#paid_listing_form').submit ->
      if $('#new-card-form').hasClass 'hidden-xl-down'
        return

      $('input[type=submit]').attr('disabled', true)
      if $('#card_number').length
        payment.processCard()
        false
      else
        true
  processCard: ->
    card =
      number: $('#card_number').val()
      cvc: $('#card_code').val()
      exp: $('#card_expiry').val()
    Stripe.createToken(card, payment.handleStripeResponse)

  handleStripeResponse: (status, response) ->
    if status == 200
      $('#token').val(response.id)
      $('#card_number').val ''
      $('#card_code').val ''
      $('#card_expiry').val ''
      $('#paid_listing_form')[0].submit()
    else
      $('.payment-errors').addClass('alert alert-danger')
      $('.payment-errors').text(response.error.message)
      $('input[type=submit]').attr('disabled', false)
