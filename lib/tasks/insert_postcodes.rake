task insert_postcodes: :environment do
  postcode_csv = 'db/postcodes.csv'
  puts 'Importing postcodes...'
  CSV.foreach(postcode_csv, headers: true) do |row|
    Postcode.find_or_create_by(code: row['postcode'], suburb: row['suburb'], state: row['state'], latitude: row['latitude'], longitude: row['longitude'])
  end
  puts "#{Postcode.count} postcodes imported successfully."
end
