class AddShortDescriptionToListings < ActiveRecord::Migration[5.2]
  def change
    add_column :listings, :short_description, :text
  end
end
