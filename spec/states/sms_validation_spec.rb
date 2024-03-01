require "states/sms_validation"
require "states/email_validation"
require "context"

RSpec.describe States::SmsValidation do
  it "transitions user to SmsValidation state" do
    context = Context.new
    context.state = States::SmsValidation
    context.next_state
    expect(context.state).to eq(States::EmailValidation)
  end
end
