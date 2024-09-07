require 'rails_helper'

RSpec.describe Api::UsersController, type: :controller do
  describe 'POST #send_selfie' do
    context 'when base64 is present' do
      before do
        Faker::Config.locale = 'pt-BR'
        user = Users::Entity.create(phone: Faker::PhoneNumber.cell_phone, email: Faker::Internet.email)
        user.check_sms_token(user.document.sms_token)
        user.check_email_token(user.document.email_token)
        post :send_selfie, params: {
          base64: 'base64',
          email: user.document.email
        }
      end

      it { expect(response).to have_http_status(:ok) }
      it { expect(JSON.parse(response.body)['message']).to eq('Selfie saved') }
    end

    context 'when base64 is not present' do
      before do
        Faker::Config.locale = 'pt-BR'
        user = Users::Entity.create(phone: Faker::PhoneNumber.cell_phone, email: Faker::Internet.email)
        user.check_sms_token(user.document.sms_token)
        user.check_email_token(user.document.email_token)
        post :send_selfie, params: {
          base64: '',
          email: user.document.email
        }
      end

      it { expect(response).to have_http_status(:bad_request) }
      it { expect(JSON.parse(response.body)['message']).to eq('Invalid selfie') }
    end
  end
end
