namespace :hawaii do
  desc "get Hawaii places from Factual"
    task get_places_data: :environment do
      require "#{Rails.root}/lib/place"
      Place.scrape
    end
  end