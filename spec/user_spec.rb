require 'user'

RSpec.describe User do
  describe "on initialization" do
    it "state should be SmsValidation" do
      user = User.new
      expect(user.state).to be(States::SmsValidation)
    end
  end
end