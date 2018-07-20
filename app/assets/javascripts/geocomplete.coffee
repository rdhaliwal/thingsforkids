$ ->
  input = document.getElementById('listing_address')
  options = {
    componentRestrictions: {country: 'au'},
    types: ['address']
  }
  autocomplete = new google.maps.places.Autocomplete(input, options)

