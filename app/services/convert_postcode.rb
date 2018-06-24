class ConvertPostcode
  include HTTParty

  URL = "https://maps.googleapis.com/maps/api/geocode/json?key=AIzaSyARuFVkZ7z_nGJQbPfySrhhqEOsVFYj0vI&address="

  def self.call postcode
    result = HTTParty.get "#{URL}#{postcode}aus"
    if result["status"] == "OK"
      location = result["results"].first["geometry"]["location"]
      latitude = location["lat"]
      longitude = location["lng"]
      [latitude, longitude]
    else
      [-37.8152065, 144.963937]
    end
  end
end
