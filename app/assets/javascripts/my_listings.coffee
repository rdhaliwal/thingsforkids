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


  MyListings.image_preview = ->
    $('.images').on 'change', ->
      image_number = this.id.split('-')[1]
      if @files[0]
        reader = new FileReader
        reader.onload = (e) ->
          $("#image_tag-#{image_number}").attr 'src', e.target.result
        reader.readAsDataURL @files[0]
).call this
