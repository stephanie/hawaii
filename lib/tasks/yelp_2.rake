namespace :hawaii do
  desc "get Yelp data v2"
    task get_yelp_data_v2: :environment do
      require "#{Rails.root}/lib/yelp"
      Yelp.fill_form
    end
  end