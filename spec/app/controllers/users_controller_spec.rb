require 'rails_helper'

RSpec.describe Api::UsersController, type: :controller do
  describe 'POST #register' do
    context 'when user is created' do
      before do
        Faker::Config.locale = 'pt-BR'
        post :register, params: {
          phone: Faker::PhoneNumber.cell_phone,
          email: Faker::Internet.email
        }
      end

      it { expect(response).to have_http_status(:ok) }
      it { expect(JSON.parse(response.body)['message']).to eq('User registered!') }
    end
  end
end
