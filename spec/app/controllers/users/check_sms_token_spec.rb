require 'rails_helper'

RSpec.describe Api::UsersController, type: :controller do
  describe 'POST #check_sms_token' do
    context 'when sms token is valid' do
      before do
        Faker::Config.locale = 'pt-BR'
        user = Users::Entity.create(phone: Faker::PhoneNumber.cell_phone, email: Faker::Internet.email)
        post :check_sms_token, params: {
          token: user.sms_token,
          email: user.email
        }
      end

      it { expect(response).to have_http_status(:ok) }
      it { expect(JSON.parse(response.body)['message']).to eq('Token is valid') }
    end

    context 'when token is NOT valid' do
      before do
        Faker::Config.locale = 'pt-BR'
        user = Users::Entity.create(phone: Faker::PhoneNumber.cell_phone, email: Faker::Internet.email)
        post :check_sms_token, params: {
          token: "#{user.document.sms_token}xx",
          email: user.email
        }
      end

      it { expect(response).to have_http_status(:bad_request) }
      it { expect(JSON.parse(response.body)['message']).to eq('Invalid token') }
    end
  end
end
