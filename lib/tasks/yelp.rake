namespace :hawaii do
  desc "get Yelp data"
    task get_yelp_data: :environment do
      require "#{Rails.root}/lib/yelp"
      # require_relative '../../app/workers/yelp_worker'
      
      Yelp.fill_form_working_version

      # YelpWorker.perform_async #UNCOMMENT TO SET UP BACKGROUND TASKS & QUEUE IN SIDEKIQ

    end
  end