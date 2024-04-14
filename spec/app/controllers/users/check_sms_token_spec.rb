require 'rails_helper'

RSpec.describe Api::UsersController, type: :controller do
  describe 'POST #check_sms_token' do
    context 'when sms token is valid', :focus do
      before do
        Faker::Config.locale = 'pt-BR'
        post :check_sms_token, params: {
          token: '1234'
        }
      end

      it { expect(response).to have_http_status(:ok) }
      it { expect(JSON.parse(response.body)['message']).to eq('Token is valid') }
    end
  end
end
