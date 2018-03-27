class ChangeStatusToIntegerInListings < ActiveRecord::Migration[5.2]
  def up
    change_column :listings, :status, 'integer USING CAST(status AS integer)'
  end

  def down
    change_column :listings, :status, :string
  end
end
