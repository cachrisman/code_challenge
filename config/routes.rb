Rails.application.routes.draw do
  get '/email_setting', to: 'email_setting#index'
  post '/email_setting', to: 'email_setting#submit'

  root 'users#index'
  resources :users
  post '/users/:id/generate_token', to: 'users#generate_token', as: 'users_generate_token'
  post '/users/:id/destroy_token', to: 'users#destroy_token', as: 'users_destroy_token'
end
