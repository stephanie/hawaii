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

  def get_businesses 
    @rows = factual.table("places-us").filters("region" => "hi").limit(50).rows


    businesses.each do |business|
      @business = Business.find_by(factual_id: business["factual_id"])
      if @business
        @business.update(business)
      else
        Business.create(business)
      end
      puts "SUCCESS: Saved business data!!!!!!!!"
    end
  end

end