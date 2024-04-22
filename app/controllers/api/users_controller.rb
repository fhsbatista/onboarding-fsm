module Api
  class UsersController < ApplicationController
    def register
      phone = params[:phone]
      email = params[:email]
      begin
        Users::Entity.create(phone:, email:)
        render json: { message: 'User registered!' }
      rescue StandardError
        render json: { message: "Couldn't create user due to missing params" }, status: :bad_request
      end
    end

    def check_sms_token
      token = params[:token]
      email = params[:email]
      user = Users::Entity.find(email)
      is_token_valid = user.check_sms_token(token)

      if is_token_valid
        render json: { message: 'Token is valid' } unless is_token_valid
      else
        render json: { message: 'Invalid token' }, status: :bad_request
      end
    end
  end
end
