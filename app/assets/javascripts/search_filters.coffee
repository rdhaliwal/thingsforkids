(->
  window.SearchFilters or (window.SearchFilters = {})

  SearchFilters.fetch_listings = ->
    $('#filters').on 'change', '.activity-check', ->
      $('.form').submit()

    $('.form, .contactForm').submit ->
      $('#loader').show()

  SearchFilters.init_scollup_button = ->
    $('#back-to-top').on 'click', ->
      $('body,html').animate { scrollTop: 0 }, 600
      $('#back-to-top').fadeOut()

    $('#listings').scroll ->
      if $('#listings').scrollTop() >= 400
        $('#back-to-top').fadeIn()
      else
        $('#back-to-top').fadeOut()

  SearchFilters.disable_content = (disable) ->
    if disable
      $('#footer, #navbar, #filters, #mobile-nav').addClass 'disabled-content'

  SearchFilters.load_listings = ->
    previous_value = 0
    $(window).data('ajaxready', true);
    $('#listings').scroll ->
      scroll_listings()

    $('.load-more-listings').click (e) ->
      preventDefault(e)
      scroll_listings()
      $(this).addClass 'd-none'


  scroll_listings = ->
    return if $(window).data('ajaxready') == false
    listings = $('#listings');
    if (listings[0].scrollHeight - listings.scrollTop() == listings.outerHeight())
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
    keys = {37: 1, 38: 1, 39: 1, 40: 1}
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
