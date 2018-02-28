class ConvertPostcode
  include HTTParty

  URL = "http://maps.googleapis.com/maps/api/geocode/json?address="

  def self.call postcode
    result = HTTParty.get "#{URL}#{postcode}"
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
