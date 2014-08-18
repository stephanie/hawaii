namespace :hawaii do
  desc "get businesses from Factual using API"
    task get_businesses_data: :environment do
      # require "#{Rails.root}/app/models/business"

      factual = Factual.new Factual::KEY, Factual::SECRET

      hi_localities = ["HONOLULU", "HILO", "KAILUA KONA", "WAILUKU", "KAILUA ", "AIEA", "WAIPAHU", "KIHEI", "LAHAINA", "KAHULUI", "LIHUE", "KANEOHE", "KAPOLEI", "KAPAA", "PEARL CITY", "TRIPLER ARMY MEDICAL CENTER", "MILILANI", "WAHIAWA", "WAIANAE", "KAMUELA", "MAKAWAO", "EWA BEACH", "HALEIWA", "KOLOA", "KEALAKEKUA", "HAIKU", "KEAAU", "PEARL HARBOR", "KULA", "WAIKOLOA", "PAHOA", "WAIMANALO", "PAIA", "KILAUEA", "HONOKAA", "KALAHEO", "KAUNAKAKAI", "WAIMEA", "CAPTAIN COOK", "HANALEI", "WAIALUA", "PRINCEVILLE", "LANAI CITY", "KAHUKU", "HANA", "HOLUALOA", "HANAPEPE", "VOLCANO", "KAPAAU", "NAALEHU"]

      hi_localities.each do |locality|
        (2..460).each do |category_id| #Factual lists 460 categories with IDs starting from 1
          count = factual.facets("places-us").select("region").filters("$and" => [{"category_ids" => {"$eq" => category_id}}, "locality" => "#{locality}"]).columns
          
          if count["region"].blank? == false
            count = (count["region"]["hi"] / 50).ceil
            if count > 9 
              count = 9
            end

            (0..count).each do |i|

              rows = factual.table("places-us").filters("$and" => [{"category_ids" => {"$eq" => category_id}}, "locality" => "#{locality}", "region" => "hi"]).offset(i*20).limit(50)

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
          end

        end
      end

      puts "#{Time.now} - Successfully saved business data!"

    end
  end