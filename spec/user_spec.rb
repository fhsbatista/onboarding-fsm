require 'user'

RSpec.describe User do
  describe "on initialization" do
    it "state should be SmsValidation" do
      user = User.new(phone: '999 999')
      expect(user.state).to be_a(States::SmsValidation)
    end
  end
end