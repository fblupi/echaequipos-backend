Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  devise_for :users

  scope module: 'api' do
    namespace :v1 do
      devise_for :users, defaults: { format: :json }, class_name: 'User'
      post '/users/update_device_token', to: 'users#update_device_token', defaults: { format: :json }
      resources :affiliations, only: [:index, :update], defaults: { format: :json } do
        resource :downgrades, only: [:update], defaults: { format: :json }, controller: 'affiliations/downgrades'
        resource :positions, only: [:show, :update], defaults: { format: :json }, controller: 'affiliations/positions'
        resource :upgrades, only: [:update], defaults: { format: :json }, controller: 'affiliations/upgrades'
      end
      resources :groups, only: [:create], defaults: { format: :json } do
        resources :affiliations, only: [:index, :create], defaults: { format: :json }, controller: 'groups/affiliations'
        resources :matches, only: [:create], defaults: { format: :json }, controller: 'groups/matches'
      end
      resources :matches, only: [:update], defaults: { format: :json } do
        resource :confirmations, only: [:update], defaults: { format: :json }, controller: 'matches/confirmations'
        resource :finishes, only: [:update], defaults: { format: :json }, controller: 'matches/finishes'
        resources :players, only: [:create], defaults: { format: :json }, controller: 'matches/players'
      end
      resources :players do
        resource :acceptances, only: [:update], defaults: { format: :json }, controller: 'players/acceptances'
        resource :rejections, only: [:update], defaults: { format: :json }, controller: 'players/rejections'
      end
      resources :positions, only: [:index], defaults: { format: :json }
    end
  end
end
