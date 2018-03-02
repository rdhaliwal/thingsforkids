class AddStripFields < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :stripe_customer_id, :string
    add_column :listings, :has_paid, :boolean, default: false
    add_column :listings, :subscription_id, :string
  end
end
