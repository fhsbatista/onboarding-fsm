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
      result, error = user.check_sms_token(token)

      if result == :error
        case error
        when :invalid_action
          return render json: { message: 'Cannot check sms token on current state' }, status: :bad_request
        else
          return render json: { message: 'Unexpected error' }, status: :bad_request
        end
      end

      is_token_valid = result != :invalid_sms_token
      return render json: { message: 'Invalid token' }, status: :bad_request unless is_token_valid

      render json: { message: 'Token is valid' }
    end

    def check_email_token
      token = params[:token]
      email = params[:email]
      user = Users::Entity.find(email)
      result, error = user.check_email_token(token)

      if result == :error
        case error
        when :invalid_action
          return render json: { message: 'Cannot check email token on current state' }, status: :bad_request
        else
          return render json: { message: 'Unexpected error' }, status: :bad_request
        end
      end

      is_token_valid = result != :invalid_email_token
      return render json: { message: 'Invalid token' }, status: :bad_request unless is_token_valid

      render json: { message: 'Token is valid' }
    end

    def send_selfie
      base64 = params[:base64]
      email = params[:email]
      user = Users::Entity.find(email)
      result, error = user.send_selfie(base64)

      if result == :error
        case error
        when :invalid_action
          return render json: { message: 'Cannot send selfie on current state' }, status: :bad_request
        else
          return render json: { message: 'Unexpected error' }, status: :bad_request
        end
      end

      is_selfie_valid = result != :invalid_selfie
      return render json: { message: 'Invalid selfie' }, status: :bad_request unless is_selfie_valid

      render json: { message: 'Selfie saved' }
    end
  end
end
