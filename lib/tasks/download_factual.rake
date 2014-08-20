namespace :hawaii do
  desc "Download Factual Data using API"
    task get_factual: :environment do

      Business.download_factual(0,21,true)
      Business.download_factual(22,49,false)

      puts "#{Time.now} - Successfully saved business data!"

    end
  end