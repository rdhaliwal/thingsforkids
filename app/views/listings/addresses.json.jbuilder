json.listings @listings.each do |listing|
  json.id listing.id
  json.address listing.full_address
end
json.ids @listings.ids
