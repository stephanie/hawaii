require 'sidekiq/web'

Hawaii::Application.routes.draw do
  mount Sidekiq::Web => '/current_tasks'

  scope :api, defaults: { format: :json } do
    resources :businesses, only: [ :index ] do
      get 'categories' => 'businesses#categories', on: :collection
    end
  end

  resources :businesses, only: [ :index, :create, :update ]
  resources :categories, only: [ :index, :create, :update ]
  get 'sample_data' => 'businesses#sample_data', as: :sample_data

  root 'businesses#index'

end
