class BusinessesController < ApplicationController

  def index 
    factual = Factual.new Factual::KEY, Factual::SECRET

    respond_to do |format|
      format.json {
        @rows = factual.table("places-us").filters("region" => "hi")
      }
      format.html {
        @rows = factual.table("places-us").filters("region" => "hi").limit(50).rows
      }
    end
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
    params.require(:business).permit(:factual_id, :address, :address_extended, :locality, :postcode, :latitude, :longitude)
  end

end