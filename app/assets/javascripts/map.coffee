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
      success: (data) ->
        if data.listings
          for listing in data.listings
            add_marker(map, bounds, geocoder, listing.address, markers, listing.id, listing.activity_type)
          google.maps.Map.prototype.markers = markers
        boundsListener = google.maps.event.addListener(map, 'bounds_changed', (event) ->
          @setZoom 11
          google.maps.event.removeListener boundsListener
          return
        )

        map.addListener 'dragend', (event) ->
          lat = event.latLng.lat()
          lng = event.latLng.lng()

          $.ajax
            type: 'GET'
            url: "/listings/addresses?lat=#{lat}&lng=#{lng}&zoom=#{map.getZoom()}",
            dataType: 'json'
            success: (data) ->
              $.post("/listings/draw?listings[]=#{data.ids}").done(->
                clear_markers(markers)
                for listing in data.listings
                  add_marker(map, bounds, geocoder, listing.address, markers, listing.id, listing.activity_type)
                google.maps.Map.prototype.markers = markers
                return
              )
    highlight_listing()

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

  add_marker =  (map, bounds, geocoder, address, markers, id, activity_type) ->
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
        if !map.center
          map.setCenter(marker.getPosition())

  clear_markers = (markers) ->
    for marker in markers
      marker.setMap(null)
    google.maps.Map.prototype.markers = []
    markers = []

  highlight_listing = ->
    $('#listings').on 'mouseenter', '.list-container', ->
        markers = google.maps.Map.prototype.markers
        for marker in markers
          if marker.id == parseInt this.href.split('/')[4]
            marker.setAnimation 1

    $('#listings').on 'mouseleave', '.list-container', ->
        markers = google.maps.Map.prototype.markers
        for marker in markers
          if marker.id == parseInt this.href.split('/')[4]
            marker.setAnimation(null)

  set_marker_icon_type = (activity_type) ->
    if activity_type == "POI"
      icon_type = {
                    path: fontawesome.markers.THUMB_TACK
                    scale: 0.5
                    strokeWeight: 0.2
                    strokeColor: 'black'
                    strokeOpacity: 1
                    fillColor: '#800080'
                    fillOpacity: 1
                  }
    else if activity_type == "Classes"
      icon_type = {
                    path: fontawesome.markers.GRADUATION_CAP
                    scale: 0.5
                    strokeWeight: 0.2
                    strokeColor: 'black'
                    strokeOpacity: 1
                    fillColor: '#F83106'
                    fillOpacity: 1
                  }
    else if activity_type == "Play Centres"
      icon_type = {
                    path: fontawesome.markers.ROCKET
                    scale: 0.5
                    strokeWeight: 0.2
                    strokeColor: 'black'
                    strokeOpacity: 1
                    fillColor: '#CB2501'
                    fillOpacity: 1
                  }
    else if activity_type == "Childcare Centres"
      icon_type = {
                    path: fontawesome.markers.HOME
                    scale: 0.5
                    strokeWeight: 0.2
                    strokeColor: 'black'
                    strokeOpacity: 1
                    fillColor: '#196F3D'
                    fillOpacity: 1
                  }
    else if activity_type == "Kid Friendly Cafes"
      icon_type = {
                    path: fontawesome.markers.COFFEE
                    scale: 0.5
                    strokeWeight: 0.2
                    strokeColor: 'black'
                    strokeOpacity: 1
                    fillColor: '#17202A'
                    fillOpacity: 1
                  }

    else if activity_type == "Parks & Playgrounds"
      icon_type = {
                    path: fontawesome.markers.TREE
                    scale: 0.5
                    strokeWeight: 0.2
                    strokeColor: 'black'
                    strokeOpacity: 1
                    fillColor: '#008000'
                    fillOpacity: 1
                  }

    return icon_type
).call this
