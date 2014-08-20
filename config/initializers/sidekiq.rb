require 'sidekiq'
require 'sidekiq/web'

Sidekiq::Web.use Rack::Auth::Basic do |username, password|
  username == 'stephs829' && password == '12345678'
end

# Sidekiq.configure_server do |config|
#   config.redis = { :url => 'redis://redis.example.com:7372/12', :namespace => 'mynamespace' }
# end

# Sidekiq.configure_client do |config|
#   config.redis = { :url => 'redis://redis.example.com:7372/12', :namespace => 'mynamespace' }
# end