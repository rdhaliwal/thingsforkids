class ConvertPostcode
  include HTTParty

  URL = "https://maps.googleapis.com/maps/api/geocode/json?key=AIzaSyARuFVkZ7z_nGJQbPfySrhhqEOsVFYj0vI&address="

  def self.call postcode
    result = HTTParty.get "#{URL}#{postcode},country=aus"
    if result["status"] == "OK"
      location = result["results"].first["geometry"]["location"]
      latitude = location["lat"]
      longitude = location["lng"]
      [latitude, longitude]
    else
      [latitude, longitude]
    end
  end
end
