Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  devise_for :users

  scope module: 'api' do
    namespace :v1 do
      devise_for :users, defaults: { format: :json }, class_name: 'User'
      post '/users/update_device_token', to: 'users#update_device_token', defaults: { format: :json }
    end
  end
end
