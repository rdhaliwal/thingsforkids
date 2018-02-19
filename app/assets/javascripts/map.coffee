(->
   window.Map or (window.Map = {})

   Map.initmap = ->
    location =
      lat: -25.363
      lng: 131.044
    map = new (google.maps.Map)(document.getElementById('map'),
      zoom: 4
      center: location)
    marker = new (google.maps.Marker)(
      position: location
      map: map)
).call this
