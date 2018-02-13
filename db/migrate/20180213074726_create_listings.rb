class CreateListings < ActiveRecord::Migration[5.2]
  def change
    create_table :listings do |t|
      t.string :business_name
      t.integer :min_age
      t.integer :max_age
      t.integer :activity_type
      t.text :days_available, default: [], array: true
      t.text :description
      t.string :logo
      t.string :facbook_url
      t.string :instagram_url
      t.string :manager_name
      t.string :manager_job_title
      t.string :phone
      t.string :email
      t.string :website
      t.decimal :price
      t.string :zip_code
      t.string :please_bring
      t.boolean :indoors
      t.boolean :outdoors
      t.boolean :parties
      t.boolean :disability_access
      t.boolean :parking
      t.boolean :free_trial
      t.boolean :undercover
      t.boolean :bbq
      t.boolean :toilets
      t.boolean :highchairs
      t.boolean :baby_change_room
      t.datetime :opens_at
      t.datetime :closes_at

      t.timestamps
    end
  end
end
