namespace :hawaii do
  desc "get Yelp data"
    task get_yelp_data: :environment do
      require "#{Rails.root}/lib/yelp"
      
      Yelp.fill_form_working_version 

      # Yelp.perform_async #queues in sidekiq to do: fix this

    end
  end