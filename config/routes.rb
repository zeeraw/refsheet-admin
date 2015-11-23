Rails.application.routes.draw do
  root controller: :gradients, action: :index
  resources :gradients, only: [:index, :create]
  scope [:gradients, :grd] do
    resources :grd_import, only: [:new], path: :import do
      post :create, on: :collection, path: :new
    end
  end
end
