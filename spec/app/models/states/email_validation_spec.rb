require 'rails_helper'

RSpec.describe States::EmailValidation do
  it 'cannot transition to EmailValidation if there is no email address' do
    user = Users::Entity.new(phone: '999 999', email: nil)
    expect { user.check_sms_token('1234') }.to raise_error(States::Errors::InvalidStateToTransition) { |e|
      expect(e.end_state).to eq(States::EmailValidation)
      expect(e.reason_type).to eq(:missing_field)
      expect(e.reason_value).to eq(:email)
      expect(user.state).to be_a(States::SmsValidation)
    }
  end

  it 'sends token on initialization' do
    user = Users::Entity.new(phone: '999 999', email: 'email@email.com')
    user.transition_state(States::EmailValidation.new(user))
    expect(user.document.email_token).not_to be_nil
  end

  it 'cannot send selfie' do
    user = Users::Entity.new(phone: '999 999', email: 'email@email.com')
    user.transition_state(States::EmailValidation.new(user))
    expect { user.send_selfie }.to raise_error(States::Errors::InvalidEvent)
  end

  describe 'check sms token' do
    it 'transitions to SendSelfie state when token is valid' do
      user = Users::Entity.new(phone: '999 999', email: 'email@email.com')
      user.transition_state(States::EmailValidation.new(user))
      valid_token = user.document.email_token
      user.check_email_token(valid_token)
      expect(user.state).to be_a(States::SendSelfie)
    end

    context 'token NOT valid' do
      it 'does not transition to SendSelfie' do
        user = Users::Entity.new(phone: '999 999', email: 'email@email.com')
        user.transition_state(States::EmailValidation.new(user))
        valid_token = user.email_token
        user.check_email_token("#{valid_token}99")
        expect(user.state).to be_a(States::EmailValidation)
      end

      it 'returns error' do
        user = Users::Entity.new(phone: '999 999', email: 'email@email.com')
        user.transition_state(States::EmailValidation.new(user))
        valid_token = user.email_token
        error = user.check_email_token("#{valid_token}99")
        expect(error).to eq(:invalid_email_token)
      end
    end
  end
end
