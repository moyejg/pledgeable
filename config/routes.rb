Rails.application.routes.draw do
  get 'home' => 'pledgeable#home'
  root 'pledgeable#home'
  
      devise_for :charities, path: 'c', controllers: {
        sessions: 'charities/sessions',
        registrations: 'charities/registrations'}
      resources :pledges
      devise_for :users, path: 'u', controllers: {
        sessions: 'users/sessions',
        registrations: 'users/registrations'}
      resources :events

  # Using checkout for saving users cards for now despite them not actually 'checking out'
  scope '/checkout' do
    post 'create', to: 'checkout#create', as: 'checkout_create'
    get 'cancel', to: 'products#index', as: 'checkout_cancel'
    get 'success', to: 'checkout#success', as: 'checkout_success'
  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
