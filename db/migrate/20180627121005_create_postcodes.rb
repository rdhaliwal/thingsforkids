class CreatePostcodes < ActiveRecord::Migration[5.2]
  def change
    create_table :postcodes do |t|
      t.integer :code
      t.string  :suburb
      t.string  :state
      t.float   :latitude
      t.float   :longitude

      t.timestamps
    end
  end
end
