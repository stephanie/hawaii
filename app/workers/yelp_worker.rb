require "#{Rails.root}/lib/yelp"

class YelpWorker
  include Sidekiq::Worker
  
  def perform()
    Yelp.fill_form_working_version()
  end
  
end