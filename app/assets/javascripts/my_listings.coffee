(->
  window.MyListings or (window.MyListings = {})

  MyListings.init = ->
    $('#ct-js-showList').on 'click', ->
      $('.ct-main-content').removeClass 'list-height'

    $('#ct-js-showTiles').on 'click', ->
      $('.ct-main-content').addClass 'list-height'

  MyListings.image_preview = ->
    $('.images').on 'change', ->
      image_number = this.id.split('-')[1]
      if @files[0]
        reader = new FileReader
        reader.onload = (e) ->
          $("#image_tag-#{image_number}").attr 'src', e.target.result
        reader.readAsDataURL @files[0]
).call this
