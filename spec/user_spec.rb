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
      expect(user.next_state).not_to be(nil)
    end
  end
end