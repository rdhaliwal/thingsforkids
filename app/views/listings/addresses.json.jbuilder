json.listings @listings.each do |listing|
  json.id listing.id
  json.address listing.full_address
  json.activity_type listing.activity_type
end
json.ids @listings.pluck(:id)
