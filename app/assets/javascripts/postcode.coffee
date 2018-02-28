(->
  window.Postcode or (window.Postcode = {})

  Postcode.init = ->
    $('#postcode-submit').click ->
      if $('#postcode-text').val().length > 0
        $('#postcode-form').addClass 'hide-form'
        $('#footer, #navbar, #filters, #mobile-nav').removeClass 'disabled-content'

).call this
