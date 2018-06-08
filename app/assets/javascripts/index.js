var map;

window.addMarkers = function addMarkers() {
  var element = document.querySelector("#listings-list");
  var listings = window.transactions = JSON.parse(element.dataset.listings);

  map.removeMarkers();

  listings.forEach(function(listing) {
    if (listing.latitude && listing.longitude) {
      var marker = map.addMarker({
        id: listing.id,
        lat: listing.latitude,
        lng: listing.longitude,
        title: listing.address,
        icon: Map.set_marker_icon_type(listing.activity_type)
      });
    }
  });

  setSafeBounds(element);
}

function setSafeBounds(element) {
  var l = element.dataset.l;
  if (l) {
    var latlngs   = l.split(',');
    var southWest = new google.maps.LatLng(latlngs[0], latlngs[1]);
    var northEast = new google.maps.LatLng(latlngs[2], latlngs[3]);
    var bounds    = new google.maps.LatLngBounds(southWest, northEast);
    map.fitBounds(bounds, 0);
    map.setZoom(12);

  } else {
    map.fitZoom();
  }
}

document.addEventListener("turbolinks:load", function() {
  if ($('#map').length) {
    map = window.map = new GMaps({
      div: '#map',
      lat: -37.8152065,
      lng: 144.963937
    });

    addMarkers();
    Map.highlight_listing();

    map.addListener("dragend", function() {
      var bounds = map.getBounds();
      var location = bounds.getSouthWest().toUrlValue() + "," + bounds.getNorthEast().toUrlValue();

      Turbolinks.visit(`/listings?l=${location}`);
    });

    map.addListener('mousemove', function() {
      map.addListener("zoom_changed", function() {
        var bounds = map.getBounds();
        var location = bounds.getSouthWest().toUrlValue() + "," + bounds.getNorthEast().toUrlValue();

        Turbolinks.visit(`/listings?l=${location}`);
      });
    });
  }
});
