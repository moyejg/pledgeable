Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  root 'pledgeable#home'
  get 'home' => 'pledgeable#home'
  get 'charities' => 'pledgeable#charities'
  get 'mark_completed' => 'events#mark_completed'
  get 'user_profile' => 'pledgeable#user_profile'
  post '/webhook_events/:source', to: 'webhook_events#create'
  
      devise_for :charities, path: 'c', controllers: {
        sessions: 'charities/sessions',
        passwords: 'charities/passwords',
        registrations: 'charities/registrations'}
      resources :pledges
      devise_for :users, path: 'u', controllers: {
        sessions: 'users/sessions',
        passwords: 'users/passwords',
        registrations: 'users/registrations'}
      resources :events

  # Using checkout for saving users cards for now despite them not actually 'checking out'
  scope '/checkout' do
    post 'create', to: 'checkout#create', as: 'checkout_create'
    get 'cancel', to: 'pledgeable#home', as: 'checkout_cancel'
    get 'success', to: 'checkout#success', as: 'checkout_success'
  end

  scope '/account' do
    post 'create', to: 'account#create', as: 'account_create'
    post 'login', to: 'account#login', as: 'account_login'
    get 'reauth', to: 'pledgeable#home', as: 'account_reauth'
    get 'return', to: 'pledgeable#home', as: 'account_return'

  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
