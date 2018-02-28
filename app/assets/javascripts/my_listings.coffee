(->
  window.MyListings or (window.MyListings = {})

  MyListings.init = ->
    $('#ct-js-showList').on 'click', ->
      $('.ct-main-content').removeClass 'list-height'

    $('#ct-js-showTiles').on 'click', ->
      $('.ct-main-content').addClass 'list-height'
).call this
