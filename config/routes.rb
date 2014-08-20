Hawaii::Application.routes.draw do

  require 'sidekiq/web'
  mount Sidekiq::Web => '/current_tasks'

  scope :api, defaults: { format: :json } do
    resources :businesses, only: [ :index ] #do
    #   get ':id' => 'businesses#index', on: :collection
    # end
  end

  resources :businesses, only: [ :index, :create, :update ]
  get 'sample_data' => 'businesses#sample_data', as: :sample_data

  root 'businesses#index'

end
