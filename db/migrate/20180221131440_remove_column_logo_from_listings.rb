class RemoveColumnLogoFromListings < ActiveRecord::Migration[5.2]
  def change
    remove_column :listings, :logo, :string
  end
end
