class CreateBusinesses < ActiveRecord::Migration
  def change
    create_table :businesses do |t|
      t.string :factual_id
      t.string :address
      t.string :address_extended
      t.string :locality
      t.integer :postcode
      t.decimal :latitude
      t.decimal :longitude

      t.timestamps
    end
  end
end
