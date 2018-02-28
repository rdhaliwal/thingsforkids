class AddUserReferenceToListings < ActiveRecord::Migration[5.2]
  def change
    add_reference :listings, :user, index: true
    add_foreign_key :listings, :users, on_delete: :cascade
  end
end
