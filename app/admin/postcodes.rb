ActiveAdmin.register Postcode do
  permit_params :code, :suburb, :state, :latitude, :longitude
end
