(->
  window.SearchFilters or (window.SearchFilters = {})

  SearchFilters.fetch_lists = ->
    $('#filters').on 'change', '.activity-check', ->
        $('.form').submit()

  SearchFilters.disable_content = (disable) ->
    if disable
      $('#footer, #navbar, #filters').addClass 'disabled-content'

).call this
