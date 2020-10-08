Rails.application.routes.draw do
  devise_for :charities, path: 'c', controllers: {
    sessions: 'charities/sessions'}
  resources :pledges
  devise_for :users, path: 'u', controllers: {
    sessions: 'users/sessions'}
  resources :events
  get "index" => "events#index"
  root "events#index"

  # Using checkout for saving users cards for now despite them not actually 'checking out'
  scope '/checkout' do
    post 'create', to: 'checkout#create', as: 'checkout_create'
    get 'cancel', to: 'products#index', as: 'checkout_cancel'
    get 'success', to: 'checkout#success', as: 'checkout_success'
  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
