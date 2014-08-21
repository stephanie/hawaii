namespace :hawaii do
  desc "Download Factual Data using API"
    task get_factual: :environment do

      require_relative '../../app/workers/factual_worker'

      # Business.download_factual(0,21,false)
      # Business.download_factual(22,49,false)

      FactualWorker.perform_async(0,21,true) #queues in sidekiq to do: fix this
      # FactualWorker.perform_async(22,49,false) #queues in sidekiq to do: fix this

      puts "#{Time.now} - Successfully saved business data!"

    end
  end