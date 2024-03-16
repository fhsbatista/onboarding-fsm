require 'user'

RSpec.describe User do
  describe "on initialization" do
    it "state should be SmsValidation" do
      user = User.new(phone: '999 999')
      expect(user.state).to be_a(States::SmsValidation)
    end
  end

  describe "on state transition" do
    it "should log" do
      user = User.new(phone: '999 999')
      log = user.transitions_logs.first
      expect(log.previous_state).to be_nil
    end
  end
end