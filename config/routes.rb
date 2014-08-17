Hawaii::Application.routes.draw do

  scope :api, defaults: { format: :json } do
    resources :businesses, except: [ :show, :new, :edit ] do
      get ':id' => 'businesses#index', on: :collection
    end
  end

  get 'yelp' => 'businesses#yelp', as: :yelp

  resources :businesses

end
