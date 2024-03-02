require 'user'
require 'states/initial_data'

RSpec.describe User do
  describe "on initialization" do
    it "state should be InitialState" do
      user = User.new
      expect(user.state).to be(States::InitialData)
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