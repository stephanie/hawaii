class FactualWorker
  include Sidekiq::Worker
  
  def perform(start=0, count=21, include_categories=false)
    Business.download_factual(start, count, include_categories)
  end
  
end