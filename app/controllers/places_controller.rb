class PlacesController < ApplicationController

  def index 
    factual = Factual.new Factual::KEY, Factual::SECRET

    respond_to do |format|
      format.json {
        @rows = factual.table("places-us").filters("region" => "hi")
      }
      format.html {
        @rows = factual.table("places-us").filters("region" => "hi").rows
      }
    end
  end

end