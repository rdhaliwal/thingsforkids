(->
  window.Map or (window.Map = {})
  Map.init = ->
    mapOptions = { zoom: 11, scrollwheel: false }

    window.bounds = new google.maps.LatLngBounds()
    window.geocoder = new google.maps.Geocoder()
    window.gmap = new google.maps.Map(document.getElementById('map'), mapOptions)
    window.gmap.setTilt(45)
    window.markers = []

    boundsListener = google.maps.event.addListener window.gmap, 'bounds_changed', ->
      @setZoom 13
      google.maps.event.removeListener boundsListener

    window.dragListener = google.maps.event.addListener window.gmap, 'dragend', ->
      if this.center
        listings_search()

    window.zoomListener = google.maps.event.addListener window.gmap, 'zoom_changed', ->
      if this.center
        listings_search()

  Map.listings = (listings, clear_marker) ->
    bounds = window.bounds
    geocoder = window.geocoder
    map = window.gmap

    if clear_marker
      clear_markers(window.markers)

    $.ajax
      type: 'GET'
      url: "/listings/addresses?listings[]=#{listings}",
      dataType: 'json'
      success: (data) ->
        if data.listings
          for listing in data.listings
            add_marker(map, bounds, geocoder, listing.address, markers, listing.id, listing.activity_type)
          window.markers = markers

    highlight_listing()

  Map.initCompanyMap = (address) ->
    Map.init()
    google.maps.event.removeListener(window.dragListener)
    google.maps.event.removeListener(window.zoomListener)
    add_marker(window.gmap, window.bounds, window.geocoder, address, [], 1)

  add_marker = (map, bounds, geocoder, address, markers, id, activity_type) ->
    icon = set_marker_icon_type(activity_type)
    geocoder.geocode { 'address': address }, (results, status) ->
      if status == 'OK'
        marker = new (google.maps.Marker)(
          map: map
          position: results[0].geometry.location
          id: id
          title: address
          icon: icon
        )

        bounds.extend(marker.position)
        markers.push marker
        if !map.center && !$('#map-center').val()
          map.setCenter(marker.getPosition())
        else if !map.center
          lat_lng = $('#map-center').val().split(',', 2)
          map.setCenter(new google.maps.LatLng(parseFloat(lat_lng[0]), parseFloat(lat_lng[1])))

  clear_markers = (markers) ->
    for marker in markers
      marker.setMap(null)
    window.markers = []
    markers = []

  highlight_listing = ->
    $('#listings').on 'mouseenter', '.list-container', ->
        markers = window.markers
        for marker in markers
          if marker.id == parseInt this.href.split('/')[4]
            marker.setAnimation 1

    $('#listings').on 'mouseleave', '.list-container', ->
        markers = window.markers
        for marker in markers
          if marker.id == parseInt this.href.split('/')[4]
            marker.setAnimation(null)

  listings_search = ->
    lat = window.gmap.getCenter().lat()
    lng = window.gmap.getCenter().lng()
    $('#loader').show()

    $.ajax
      type: 'GET'
      url: "/listings/addresses?lat=#{lat}&lng=#{lng}&zoom=#{window.gmap.getZoom()}",
      dataType: 'json'
      success: (data) ->
        $("input[name='q[id_in][]'").remove()
        $('#map-center').val("#{lat},#{lng}")

        if data.ids.length != 0
          for id in data.ids
            $('<input>').attr(
              type: 'hidden'
              value: id
              name: 'q[id_in][]').appendTo '.form'
        else
          $('<input>').attr(
            type: 'hidden'
            value: '-9999'
            name: 'q[id_in][]').appendTo '.form'

        $('.form').submit()

  set_marker_icon_type = (activity_type) ->
    if activity_type == "POI"
      return "/assets/POI.png"
    else if activity_type == "Classes"
      return "/assets/classes.png"
    else if activity_type == "Play Centres"
      return "/assets/playcentre.png"
    else if activity_type == "Childcare Centres"
      return "/assets/childcare.png"
    else if activity_type == "Kid Friendly Cafes"
      return "/assets/cafe.png"
    else if activity_type == "Parks & Playgrounds"
      return "/assets/parkplaygrounds.png"

).call this
