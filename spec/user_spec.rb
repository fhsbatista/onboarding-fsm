require 'user'

RSpec.describe User do
  describe "on initialization" do
    it "state should be SmsValidation" do
      user = User.new(phone: '999 999')
      expect(user.state).to be_a(States::SmsValidation)
    end

    it "transations logs should be empty" do
      user = User.new(phone: '999 999')
      expect(user.transitions_logs).to be_empty
    end
  end
end