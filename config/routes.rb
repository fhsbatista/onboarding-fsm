Rails.application.routes.draw do
  namespace :api do
    post 'users/register', to: 'users#register'
    post 'users/check_sms_token', to: 'users#check_sms_token'
    post 'users/check_email_token', to: 'users#check_email_token'
    post 'users/send_selfie', to: 'users#send_selfie'
  end
end
