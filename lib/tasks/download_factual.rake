namespace :hawaii do
  desc "Download Factual Data using API"
    task get_factual: :environment do

      require_relative '../../app/workers/factual_worker'

      # #localities with more than 500 businesses
      # Business.download_factual(0,21,true)
      # #localities with less than 500 businesses
      # Business.download_factual(22,49,false)

      #retail categories
      # Business.download_factual(0,49,true,123,176)
      Business.download_factual_retail

      # FactualWorker.perform_async(0,21,true)  #UNCOMMENT TO SET UP BACKGROUND TASKS & QUEUE IN SIDEKIQ
      # FactualWorker.perform_async(22,49,false)  #UNCOMMENT TO SET UP BACKGROUND TASKS & QUEUE IN SIDEKIQ

      puts "#{Time.now} - Successfully saved business data!"

    end
  end