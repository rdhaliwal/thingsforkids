(->
  window.MyListings or (window.MyListings = {})

  MyListings.init = ->
    $('#ct-js-showList').on 'click', ->
      $('.ct-main-content').removeClass 'list-height'

    $('#ct-js-showTiles').on 'click', ->
      $('.ct-main-content').addClass 'list-height'

    $('#continue-step2').on 'click', (e) ->
      e.preventDefault()
      $('#step1-counter').removeClass('ct-steps--active')
      $('#step2-counter').addClass('ct-steps--active')
      $('#info-form').addClass 'hide-form'
      $('#amenities-form').removeClass 'hide-form'

    $('#backto-step1').on 'click', (e) ->
      e.preventDefault()
      $('#step1-counter').addClass('ct-steps--active')
      $('#step2-counter').removeClass('ct-steps--active')
      $('#amenities-form').addClass 'hide-form'
      $('#info-form').removeClass 'hide-form'

    $('#continue-step3').on 'click', (e) ->
      e.preventDefault()
      $('#step2-counter').removeClass('ct-steps--active')
      $('#step3-counter').addClass('ct-steps--active')
      $('#images-form').removeClass 'hide-form'
      $('#amenities-form').addClass 'hide-form'

    $('#backto-step2').on 'click', (e) ->
      e.preventDefault()
      $('#step2-counter').addClass('ct-steps--active')
      $('#step3-counter').removeClass('ct-steps--active')
      $('#images-form').addClass 'hide-form'
      $('#amenities-form').removeClass 'hide-form'

    $('#continue-step4').on 'click', (e) ->
      e.preventDefault()
      $('#step3-counter').removeClass('ct-steps--active')
      $('#step4-counter').addClass('ct-steps--active')
      $('#price-from').removeClass 'hide-form'
      $('#images-form').addClass 'hide-form'

    $('#backto-step3').on 'click', (e) ->
      e.preventDefault()
      $('#step3-counter').addClass('ct-steps--active')
      $('#step4-counter').removeClass('ct-steps--active')
      $('#price-from').addClass 'hide-form'
      $('#images-form').removeClass 'hide-form'

    $('#backto-step1-free').on 'click', (e) ->
      e.preventDefault()
      $('#step1-counter').addClass('ct-steps--active')
      $('#step2-counter').removeClass('ct-steps--active')
      $('#amenities-form').addClass 'hide-form'
      $('#info-form').removeClass 'hide-form'


  MyListings.image_preview = ->
    $('.images').on 'change', ->
      image_number = this.id.split('-')[1]
      if @files[0]
        reader = new FileReader
        reader.onload = (e) ->
          $("#image_tag-#{image_number}").attr 'src', e.target.result
        reader.readAsDataURL @files[0]

).call this
