require 'rails_helper'

RSpec.describe States::SmsValidation do
  it 'cannot transition to Smsvalidation if there is no phone number' do
    user = Users::Entity.create(phone: Faker::PhoneNumber.cell_phone, email: Faker::Internet.email)
    allow(user).to receive(:phone).and_return(nil)
    expect { States::SmsValidation.new(user) }.to raise_error(States::Errors::InvalidStateToTransition) { |e|
      expect(e.end_state).to eq(States::SmsValidation)
      expect(e.reason_type).to eq(:missing_field)
      expect(e.reason_value).to eq(:phone)
    }
  end

  it 'sends token on initialization' do
    user = Users::Entity.create(phone: '999 999', email: Faker::Internet.email)
    expect(user.document.sms_token).not_to be_nil
  end

  it 'cannot send selfie' do
    user = Users::Entity.create(phone: '999 999', email: Faker::Internet.email)
    user.transition_state(States::SmsValidation)
    expect(user.send_selfie('base64')).to eq(%i[error invalid_action])
  end

  describe 'check sms token' do
    it 'transitions to EmailValidation state when token is valid' do
      user = Users::Entity.create(phone: '999 999', email: 'email@email.com')
      valid_token = user.document.sms_token
      user.check_sms_token(valid_token)
      expect(user.state).to be_a(States::EmailValidation)
    end

    context 'token NOT valid' do
      it 'does not transition to EmailValidation' do
        user = Users::Entity.create(phone: '999 999', email: Faker::Internet.email)
        valid_token = user.sms_token
        user.check_sms_token("#{valid_token}99")
        expect(user.state).to be_a(States::SmsValidation)
      end

      it 'returns error' do
        user = Users::Entity.create(phone: '999 999', email: Faker::Internet.email)
        valid_token = user.sms_token
        error = user.check_sms_token("#{valid_token}99")
        expect(error).to eq(:invalid_sms_token)
      end
    end
  end
end
