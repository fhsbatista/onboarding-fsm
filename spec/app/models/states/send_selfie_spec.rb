require 'rails_helper'

RSpec.describe States::EmailValidation do
  it 'cannot check email' do
    user = Users::Entity.create(phone: '999 999', email: 'email@email.com')
    user.transition_state(States::SendSelfie.new(user))
    expect(user.check_email_token('1234')).to eq(%i[error invalid_action])
  end

  describe 'check sms token' do
    let(:user) {
      user = Users::Entity.create(phone: '999 999', email: 'email@email.com')
      user.transition_state(States::SendSelfie.new(user))
      user
    }

    context 'selfie is valid' do
      let(:selfie) { 'base64' }
      it 'transitions to Active state' do
        user.send_selfie(selfie)
        expect(user.state).to be_a(States::Active)
      end

      it 'selfie is persisted' do
        user.send_selfie(selfie)
        expect(user.document.selfie).to eq(selfie)
      end
    end

    context 'selfie is not valid' do
      let(:selfie) { '' }
      it 'does not transition to Active' do
        user.send_selfie(selfie)
        expect(user.state).to be_a(States::SendSelfie)
      end

      it 'returns error' do
        error = user.send_selfie(selfie)
        expect(error).to eq(:invalid_selfie)
      end

      it 'user self remains blank' do
        user.send_selfie('')
        expect(user.selfie).to be_blank
      end
    end
  end
end
