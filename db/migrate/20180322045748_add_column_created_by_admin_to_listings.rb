class AddColumnCreatedByAdminToListings < ActiveRecord::Migration[5.2]
  def change
    add_column :listings, :created_by_admin, :boolean, default: false
  end
end
