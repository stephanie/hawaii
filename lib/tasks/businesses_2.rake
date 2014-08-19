namespace :hawaii do
  desc "get businesses from Factual using API: Part 2"
    task get_businesses_data_2: :environment do
      # require "#{Rails.root}/app/models/business"

      factual = Factual.new Factual::KEY, Factual::SECRET

      #Localities with less than 500 businesses, within row limit
      hi_localities = ["KOLOA", "HALEIWA", "KEALAKEKUA" , "HAIKU", "PEARL HARBOR", "KEAAU", "KULA" , "WAIKOLOA" , "PAHOA", "WAIMANALO", "PAIA" , "KILAUEA", "HONOKAA", "KAUNAKAKAI" , "KALAHEO", "WAIMEA" , "HANALEI", "CAPTAIN COOK", "PRINCEVILLE", "WAIALUA", "LANAI CITY", "KAHUKU" , "HANA" , "VOLCANO", "KAPAAU" , "HANAPEPE" , "HOLUALOA" , "HAUULA"]

      hi_localities.each do |locality|
        count = factual.facets("places-us").select("region").filters("locality" => "#{locality}").columns
        
        # if count["region"].blank? == false
          count = (count["region"]["hi"] / 20).ceil
          if count > 24
            count = 24
          end

          (0..count).each do |i|

            rows = factual.table("places-us").filters("$and" => ["locality" => "#{locality}", "region" => "hi"]).offset(i*20)

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
                longitude: row["longitude"],
                category_ids: row["category_ids"]
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
        # end

      end

      puts "#{Time.now} - Successfully saved business data!"

    end
  end