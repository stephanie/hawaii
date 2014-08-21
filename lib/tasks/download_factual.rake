namespace :hawaii do
  desc "Download Factual Data using API"
    task get_factual: :environment do

      require_relative '../../app/workers/factual_worker'

      Business.download_factual(0,21,false)
      Business.download_factual(22,49,false)

      # FactualWorker.perform_async(0,21,true)  #UNCOMMENT TO SET UP BACKGROUND TASKS & QUEUE IN SIDEKIQ
      # FactualWorker.perform_async(22,49,false)  #UNCOMMENT TO SET UP BACKGROUND TASKS & QUEUE IN SIDEKIQ

      puts "#{Time.now} - Successfully saved business data!"

    end
  end