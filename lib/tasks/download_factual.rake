namespace :hawaii do
  desc "Download Factual Data using API"
    task get_factual: :environment do

      Business.download_factual(0,21,true)
      Business.download_factual(22,49,false)

      # Business.perform_async(0,21,true) #queues in sidekiq to do: fix this
      # Business.perform_async(22,49,false) #queues in sidekiq to do: fix this

      puts "#{Time.now} - Successfully saved business data!"

    end
  end