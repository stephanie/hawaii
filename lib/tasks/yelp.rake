namespace :hawaii do
  desc "get Yelp data"
    task get_yelp_data: :environment do
      require "#{Rails.root}/lib/yelp"
      Yelp.fill_form
    end
  end