(->
  window.Map or (window.Map = {})

  Map.initListingMap = (listings) ->
    map = undefined
    bounds = new google.maps.LatLngBounds()
    geocoder = new google.maps.Geocoder()
    map = set_properties(map)
    icon = $('#map').data('icon')

    $.ajax
      type: 'GET'
      url: "/listings/addresses?listings[]=#{listings}",
      dataType: 'json'
      success: (listings) ->
        for listing_address in listings.listings
          add_marker(map, bounds, geocoder, listing_address, icon)

        boundsListener = google.maps.event.addListener(map, 'bounds_changed', (event) ->
          @setZoom 11
          google.maps.event.removeListener boundsListener
          return
        )

  Map.initCompanyMap = (address) ->
    map = undefined
    bounds = new google.maps.LatLngBounds()
    geocoder = new google.maps.Geocoder()
    map = set_properties(map)
    icon = $('#map').data('url')
    add_marker(map, bounds, geocoder, address, icon)

  set_properties = (map) ->
    mapOptions = {
                zoom: 11,
                zoomControl: true,
                zoomControlOptions: {
                    style: google.maps.ZoomControlStyle.SMALL,
                },
                disableDoubleClickZoom: true,
                mapTypeControl: false,
                panControl: false,
                scaleControl: false,
                scrollwheel: false,
                streetViewControl: false,
                draggable : true,
                overviewMapControl: false,
                mapTypeId: google.maps.MapTypeId.ROADMAP,
                styles: [{
                    featureType: 'all',
                    stylers: [
                        {saturation: -100},
                        {gamma: 0.50}
                    ]
                }]
            }
    map = new (google.maps.Map)(document.getElementById('map'), mapOptions)
    map.setTilt(45)
    return map

  add_marker =  (map, bounds, geocoder, address, icon) ->
    geocoder.geocode { 'address': address }, (results, status) ->
      if status == 'OK'
        marker = new (google.maps.Marker)(
          map: map
          position: results[0].geometry.location
          title: address
          icon: icon)
        bounds.extend(marker.position)
        map.setCenter marker.getPosition()
).call this
