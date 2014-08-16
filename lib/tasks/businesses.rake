namespace :hawaii do
  desc "get businesses from Factual using API"
    task get_businesses_data: :environment do
      factual = Factual.new Factual::KEY, Factual::SECRET

      rows = factual.table("places-us").filters("region" => "hi").limit(50).rows

      business_data = []
      rows.each do |row|
        business_data.push({
          factual_id: row["factual_id"],
          address: row["address"],
          address_extended: row["address_extended"],
          locality: row["locality"],
          postcode: row["postcode"],
          latitude: row["latitude"],
          longitude: row["longitude"]
        })
      end

      business_data.each do |business|
        @business = Business.find_by(factual_id: business[:factual_id])
        if @business
          @business.update(business)
        else
          Business.create(business)
        end
      end

      puts "#{Time.now} - Successfully saved business data!"

    end
  end