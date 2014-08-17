class CreateBusinesses < ActiveRecord::Migration
  def change
    create_table :businesses do |t|
      t.string :name
      t.string :factual_id
      t.string :address
      t.string :address_extended
      t.string :locality
      t.integer :postcode
      t.float :latitude
      t.float :longitude

      t.timestamps
    end
  end
end
