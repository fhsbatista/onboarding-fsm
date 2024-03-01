require "context"
require "transition"
require "date_time"
require "states/initial_data"

RSpec.describe Context do
  it "returns a transition when go to next state" do
    context = Context.new
    context.state = States::InitialData
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
