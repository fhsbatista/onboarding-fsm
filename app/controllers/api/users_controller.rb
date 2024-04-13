module Api
  class UsersController < ApplicationController
    def register
      phone = params[:phone]
      email = params[:email]
      Users::Entity.new(phone:, email:)
      render json: { message: 'User registered!' }
    end
  end
end
