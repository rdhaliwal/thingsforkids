class SetDefaultMinAndMaxAge < ActiveRecord::Migration[5.2]
  def change
    change_column :listings, :min_age, :integer, default: 0
    change_column :listings, :max_age, :integer, default: 10
  end
end
