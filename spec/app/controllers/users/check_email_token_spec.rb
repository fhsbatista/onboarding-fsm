require 'rails_helper'

RSpec.describe Api::UsersController, type: :controller do
  describe 'POST #check_email_token' do
    context 'when email token is valid' do
      before do
        Faker::Config.locale = 'pt-BR'
        user = Users::Entity.create(phone: Faker::PhoneNumber.cell_phone, email: Faker::Internet.email)
        user.check_sms_token(user.document.sms_token)
        post :check_email_token, params: {
          token: user.document.email_token,
          email: user.document.email
        }
      end

      it { expect(response).to have_http_status(:ok) }
      it { expect(JSON.parse(response.body)['message']).to eq('Token is valid') }
    end

    context 'when token is NOT valid' do
      before do
        Faker::Config.locale = 'pt-BR'
        user = Users::Entity.create(phone: Faker::PhoneNumber.cell_phone, email: Faker::Internet.email)
        user.check_sms_token(user.document.sms_token)
        post :check_email_token, params: {
          token: "#{user.document.email_token}xx",
          email: user.document.email
        }
      end

      it { expect(response).to have_http_status(:bad_request) }
      it { expect(JSON.parse(response.body)['message']).to eq('Invalid token') }
    end
  end
end
