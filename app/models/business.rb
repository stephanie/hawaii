class Business < ActiveRecord::Base

  # def self.get_data
  #   factual = Factual.new Factual::KEY, Factual::SECRET
  #   rows = factual.table("places-us").filters("region" => "hi").limit(50).rows

  #   business_data = []
  #   rows.each do |row|
  #     business_data.push({
  #       name: row["name"],
  #       factual_id: row["factual_id"],
  #       address: row["address"],
  #       address_extended: row["address_extended"],
  #       locality: row["locality"],
  #       postcode: row["postcode"],
  #       latitude: row["latitude"],
  #       longitude: row["longitude"]
  #     })
  #   end
  # end

end
