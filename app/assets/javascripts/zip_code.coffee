(->
  window.ZipCode or (window.ZipCode = {})

  ZipCode.init = ->
    $('#zip-code-submit').click ->
      if $('#zip-code-text').val().length > 0
        $('#zipcode-form').addClass 'hide-form'
        $('#footer, #navbar, #filters').removeClass 'disabled-content'

).call this
