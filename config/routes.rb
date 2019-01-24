Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  devise_for :users

  scope module: 'api' do
    namespace :v1 do
      devise_for :users, defaults: { format: :json }, class_name: 'User'
      post '/users/update_device_token', to: 'users#update_device_token', defaults: { format: :json }
      namespace :affiliations do
        resources :downgrades, only: [:update], defaults: { format: :json }
        resources :invitations, only: [:create, :update], defaults: { format: :json }
        resources :positions, only: [:show], defaults: { format: :json }
        resources :positions, only: [:update], defaults: { format: :json }
        resources :upgrades, only: [:update], defaults: { format: :json }
      end
      resources :groups, only: [:create], defaults: { format: :json } do
        resources :affiliations, only: [:index], defaults: { format: :json }, controller: 'groups/affiliations'
        resources :matches, only: [:create], defaults: { format: :json }, controller: 'groups/matches'
      end
      namespace :matches do
        resources :confirmations, only: [:update], defaults: { format: :json }
        resources :finishes, only: [:update], defaults: { format: :json }
      end
      resources :positions, only: [:index], defaults: { format: :json }
      namespace :users do
        resources :affiliations, only: [:index], defaults: { format: :json }
      end
    end
  end
end
