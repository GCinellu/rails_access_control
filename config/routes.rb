Rails.application.routes.draw do

  devise_for :users
  resources :companies do
    get '/my-company' => 'companies#show'

    resources :teams
    resources :wishes

    resources :departments do
      resources :teams
      resources :wishes
    end
  end



  root 'static#home'
end
