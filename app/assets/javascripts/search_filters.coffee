(->
  window.SearchFilters or (window.SearchFilters = {})

  SearchFilters.fetch_lists = ->
    $('#filters').on 'change', '.activity-check', ->
        $('.form').submit()

  SearchFilters.disable_content = (disable) ->
    if disable
      $('#footer, #navbar, #filters').addClass 'disabled-content'

  SearchFilters.load_lists = ->
    $(window).data('ajaxready', true).scroll ->
      return if $(window).data('ajaxready') == false
      if ($(document).scrollTop() >= ($(document).height() - $(window).height()) - 600)
        $(window).data('ajaxready', false);
        url = $('.pagination .next-page').attr('href')
        if url
          $.getScript(url).done (script) ->
            $(window).data('ajaxready', true)

).call this
