class CreateInvoices < ActiveRecord::Migration[5.2]
  def change
    create_table :invoices do |t|
      t.references :listing, index: true
      t.string :stripe_invoice_id
      t.integer :amount

      t.timestamps
    end
    add_foreign_key :invoices, :listings, on_delete: :cascade
  end
end
