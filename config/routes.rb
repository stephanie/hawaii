Hawaii::Application.routes.draw do

  scope :api, defaults: { format: :json } do
    resources :businesses, except: [ :show, :new, :edit ] do
      get ':id' => 'businesses#index', on: :collection
    end
  end

  resources :businesses

end
