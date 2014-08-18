class BusinessesController < ApplicationController

  def sample_data 
    factual = Factual.new Factual::KEY, Factual::SECRET

    @rows = factual.table("places-us").filters("$and" => [{"category_ids" => {"$eq" => 2}}, "locality" => "honolulu", "region" => "hi"])
    @yelp = factual.table("crosswalk").filters("factual_id" => "3b9e2b46-4961-4a31-b90a-b5e0aed2a45e", "namespace" => "yelp").rows
  end

  def index
    respond_to do |format|
      format.json {
        @businesses = Business.all
      }
      format.html {
        
      }
    end
  end

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