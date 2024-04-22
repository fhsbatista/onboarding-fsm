require 'rails_helper'

RSpec.describe Users::Entity do
  context 'on initialization' do
    it 'state should be SmsValidation' do
      user = Users::Entity.create(phone: '999 999', email: Faker::Internet.email)
      expect(user.state).to be_a(States::SmsValidation)
    end

    it 'does not persist user if cannot transition to SmsValidation' do
      expect { Users::Entity.create(phone: nil) }.to raise_error(States::Errors::InvalidStateToTransition) { |e|
        expect(Users::Document.all.empty?).to be_truthy
      }
    end
  end

  context 'on state transition' do
    it 'logs' do
      user = Users::Entity.create(phone: '999 999', email: 'test@test.com')
      user.transition_state(States::EmailValidation.new(user))
      log = user.transition_logs[1]

      expect(log.previous_state).to eq('sms_validation')
      expect(log.current_state).to eq('email_validation')

      secs_tolerance = 1
      expect(log.date_time.to_time).to be_within(secs_tolerance).of(Time.zone.now)
    end
  end
end
