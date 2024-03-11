require 'user'
require 'states/initial_data'

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

  it "returns a transition when go to next state" do
    context = User.new
    context.state = States::InitialData
    context.phone = '111 991 999'
    transition = context.next_state
    expected_transition = Transition.new(
      context: context,
      start_state: States::InitialData,
      end_state: context.state,
      time: DateTime.no_usec(Time.now)
    )
    expect(transition).to eq(expected_transition)
  end
end