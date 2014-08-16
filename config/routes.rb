Hawaii::Application.routes.draw do

  scope :api, defaults: { format: :json } do
    resources :places, except: [ :show, :new, :edit ] do
      get ':id' => 'places#index', on: :collection
    end
  end

  resources :places

end
