require 'user'

RSpec.describe User do
  describe "on initialization" do
    it "state should be SmsValidation" do
      user = User.new
      expect(user.state).to be(States::SmsValidation)
    end

    it "can transition state" do
      user = User.new
      previous = user.state
      user.phone = '111 991 999'
      user.next_state
      current = user.state
      expect(current).not_to be(previous)
    end
  end
end