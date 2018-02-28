class RenameZipCodeInListings < ActiveRecord::Migration[5.2]
  def change
    rename_column :listings, :zip_code, :postcode
  end
end
