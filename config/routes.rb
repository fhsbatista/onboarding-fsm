Rails.application.routes.draw do
  namespace :api do
    post 'users/register', to: 'users#register'
    post 'users/check_sms_token', to: 'users#check_sms_token'
    post 'users/check_email_token', to: 'users#check_email_token'
  end
end
