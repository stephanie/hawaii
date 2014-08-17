namespace :hawaii do
  desc "get businesses from Factual using API"
    task get_businesses_data: :environment do
      # require "#{Rails.root}/app/models/business"

      factual = Factual.new Factual::KEY, Factual::SECRET

      count = factual.facets("places-us").select("region").filters("region" => "HI").min_count(20).limit(5).columns
      count = (count["region"]["hi"] / 20).ceil

      (0..count).each do |i|

        rows = factual.table("places-us").filters("region" => "hi").offset(i*20)

        business_data = []
        rows.each do |row|
          business_data.push({
            name: row["name"],
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

      end

      puts "#{Time.now} - Successfully saved business data!"
      puts count

    end
  end