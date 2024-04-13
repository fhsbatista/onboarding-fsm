Rails.application.routes.draw do
  namespace :api do
    post 'users/register', to: 'users#register'
  end
end
