(->
  window.MyListings or (window.MyListings = {})

  MyListings.init = ->
    $('#ct-js-showList').on 'click', ->
      $('.ct-main-content').removeClass 'list-height'

    $('#ct-js-showTiles').on 'click', ->
      $('.ct-main-content').addClass 'list-height'

    $('#edit_basic_info').on 'click', (e) ->
      e.preventDefault()
      $('#basic_info_fields').removeClass 'd-none'
      $('#images_form_fields').addClass 'd-none'
      $('#amenities_fields').addClass 'd-none'

    $('#edit_amenities').on 'click', (e) ->
      e.preventDefault()
      $('#amenities_fields').removeClass 'd-none'
      $('#images_form_fields').addClass 'd-none'
      $('#basic_info_fields').addClass 'd-none'

    $('#edit_images').on 'click', (e) ->
      e.preventDefault()
      $('#images_form_fields').removeClass 'd-none'
      $('#amenities_fields').addClass 'd-none'
      $('#basic_info_fields').addClass 'd-none'

    $('.count-words').keyup ->
      max_words = $(this).data('max-words')
      count_field = $(this).data('count-field')
      words = $(this).val().split(' ').length
      if max_words >= words
        $(count_field).html("#{max_words - words} words remaning")
      else
        $(count_field).html("words limit exceeded")

  MyListings.change_step = (step) ->
    if step == 2
      $('#step1-counter').parent().addClass 'ct-steps--progress'
      $('#step2-counter').addClass 'ct-steps--active'
    else if step == 3
      $('#step1-counter').parent().addClass 'ct-steps--past'
      $('#step2-counter').parent().addClass 'ct-steps--progress'
      $('#step3-counter').addClass 'ct-steps--active'
    else if step == 4
      $('#step1-counter, #step2-counter').parent().addClass 'ct-steps--past'
      $('#step3-counter').parent().addClass 'ct-steps--progress'
      $('#step4-counter').addClass 'ct-steps--active'

  MyListings.image_preview = ->
    $('.images').on 'change', ->
      image_number = this.id.split('-')[1]
      if @files[0]
        reader = new FileReader
        reader.onload = (e) ->
          $("#image_tag-#{image_number}").attr 'src', e.target.result
        reader.readAsDataURL @files[0]

).call this
