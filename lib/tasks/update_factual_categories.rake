namespace :hawaii do
  desc "Update Factual Categories using API"
    task update_factual_categories: :environment do

      Category.update_category_labels

      puts "#{Time.now} - Successfully saved categories data!"

    end
  end