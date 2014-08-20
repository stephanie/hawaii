require 'sidekiq'
require 'sidekiq/web'

Sidekiq::Web.use Rack::Auth::Basic do |username, password|
  username == 'stephs829' && password == '12345678'
end