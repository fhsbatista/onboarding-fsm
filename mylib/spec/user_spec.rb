require "user"

RSpec.describe User do
  describe "on initialization" do
    it "state should be SmsValidation" do
      user = User.new(phone: "999 999")
      expect(user.state).to be_a(States::SmsValidation)
    end
  end

  describe "on state transition" do
    it "should log" do
      user = User.new(phone: "999 999", email: "test@test.com")
      user.transition_state(States::EmailValidation.new(user))
      log = user.transitions_logs[1]

      expect(log.previous_state).to be_a(States::SmsValidation)

      expect(log.current_state).to be_a(States::EmailValidation)

      secs_tolerance = 1
      expect(log.date_time).to be_within(secs_tolerance).of(Time.now)
    end
  end
end
