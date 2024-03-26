require "rails_helper"

RSpec.describe Users::Entity do
  context "on initialization" do
    it "state should be SmsValidation" do
      user = Users::Entity.new(phone: "999 999")
      expect(user.state).to be_a(States::SmsValidation)
    end
  end

  context "on state transition" do
    it "should log" do
      user = Users::Entity.new(phone: "999 999", email: "test@test.com")
      user.transition_state(States::EmailValidation.new(user))
      log = user.transition_logs[1]

      expect(log.previous_state).to eq('sms_validation')
      expect(log.current_state).to eq('email_validation')

      secs_tolerance = 1
      expect(log.date_time.to_time).to be_within(secs_tolerance).of(Time.now)
    end
  end
end