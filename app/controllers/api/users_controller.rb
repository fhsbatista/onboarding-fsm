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
      user_document = Users::Document.where(email:).first
      user_entity =

        render json: { message: 'Token is valid' }
    end
  end
end
