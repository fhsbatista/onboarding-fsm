require "states/initial_data"
require "states/sms_validation"
require "context"

RSpec.describe States::InitialData do
  it "transitions user to SmsValidation state" do
    context = Context.new
    context.state = States::InitialData
    context.phone = '111 991 999'
    context.next_state
    expect(context.state).to be_an_instance_of(States::SmsValidation)
  end
end
