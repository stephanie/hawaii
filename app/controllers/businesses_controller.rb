class BusinessesController < ApplicationController

  def index 
    factual = Factual.new Factual::KEY, Factual::SECRET

    respond_to do |format|
      format.json {
        @rows = factual.table("places-us").filters("region" => "hi")
      }
      format.html {
        # @rows = factual.table("places-us").filters("region" => "hi").rows
        @rows = factual.table("places-us").filters("$and" => [{"category_ids" => {"$includes" => 342}}, "locality" => "honolulu", "region" => "hi"])
        # @rows = factual.table("places-us").filters("$and" => [{"category_ids" => {"$includes" => 400}}, "region" => "hi"]).rows
      }
    end
  end

  def yelp
    factual = Factual.new Factual::KEY, Factual::SECRET

    @rows = factual.table("crosswalk").filters("factual_id" => "3b9e2b46-4961-4a31-b90a-b5e0aed2a45e", "namespace" => "yelp").rows

    @count = factual.facets("places-us").select("region").filters("region" => "HI").min_count(20).limit(5).columns
  end

  # def get_businesses 
  #   factual = Factual.new Factual::KEY, Factual::SECRET

  #   @rows = factual.table("places-us").filters("region" => "hi").limit(50).rows

  #   business_data = []
  #   @rows.each do |row|
  #     business_data.push({
  #       factual_id: row["factual_id"],
  #       address: row["address"],
  #       address_extended: row["address_extended"],
  #       locality: row["locality"],
  #       postcode: row["postcode"],
  #       latitude: row["latitude"],
  #       longitude: row["longitude"]
  #     })
  #   end


  #   businesses.each do |business|
  #     @business = Business.find_by(factual_id: business["factual_id"])
  #     if @business
  #       @business.update(business)
  #     else
  #       Business.create(business)
  #     end
  #     puts "SUCCESS: Saved business data!!!!!!!!"
  #   end

  # end

  def create
    @business = Business.new(business_params)
  end

  def update
    @business.update(business_params)

    redirect_to businesses_path
  end

  private

  def business_params
    params.require(:business).permit(:name, :factual_id, :address, :address_extended, :locality, :postcode, :latitude, :longitude)
  end

end