(->
  window.SearchFilters or (window.SearchFilters = {})

  SearchFilters.fetch_lists = ->
    $('#filters').on 'change', '.activity-check', ->
      $('#loader').show()
      $('.form').submit()

  SearchFilters.disable_content = (disable) ->
    if disable
      $('#footer, #navbar, #filters, #mobile-nav').addClass 'disabled-content'

  SearchFilters.load_lists = ->
    previous_value = 0
    keys = {37: 1, 38: 1, 39: 1, 40: 1}
    $(window).data('ajaxready', true).scroll ->
      return if $(window).data('ajaxready') == false
      if $('#listings').scrollTop() - previous_value >= 400
        previous_value = $('#listings').scrollTop()
        $(window).data('ajaxready', false);
        url = $('.pagination .next-page').attr('href')
        if url
          disableScroll()
          $('#loader').show()
          $.getScript(url).done (script) ->
            $(window).data('ajaxready', true)
            $('#loader').hide()
            enableScroll()

  preventDefault = (e) ->
    e = e or window.event
    if e.preventDefault
      e.preventDefault()
    return e.returnValue = false

  preventDefaultForScrollKeys = (e) ->
    if keys[e.keyCode]
      preventDefault e
      return false

  disableScroll = ->
    if window.addEventListener
      window.addEventListener 'DOMMouseScroll', preventDefault, false
    window.onwheel = preventDefault
    window.onmousewheel = document.onmousewheel = preventDefault
    window.ontouchmove = preventDefault
    document.onkeydown = preventDefaultForScrollKeys

  enableScroll = ->
    if window.removeEventListener
      window.removeEventListener 'DOMMouseScroll', preventDefault, false
    window.onmousewheel = document.onmousewheel = null
    window.onwheel = null
    window.ontouchmove = null
    document.onkeydown = null

).call this
