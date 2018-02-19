(->
  window.Map or (window.Map = {})

  Map.initmap = (listings) ->
    map = undefined
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
    bounds = new google.maps.LatLngBounds()
    geocoder = new google.maps.Geocoder()

    map = new (google.maps.Map)(document.getElementById('map'), mapOptions)
    map.setTilt(45)

    $.ajax
      type: 'GET'
      url: "/home/addresses?listings[]=#{listings}",
      dataType: 'json'
      success: (listings) ->
        for listing_address in listings.listings
          geocoder.geocode { 'address': listing_address }, (results, status) ->
            if status == 'OK'
              marker = new (google.maps.Marker)(
                map: map
                position: results[0].geometry.location
                title: listing_address)
              bounds.extend(marker.position)
              map.setCenter marker.getPosition()
            else
              alert "Address not found."

        boundsListener = google.maps.event.addListener(map, 'bounds_changed', (event) ->
          @setZoom 11
          google.maps.event.removeListener boundsListener
          return
        )
).call this
