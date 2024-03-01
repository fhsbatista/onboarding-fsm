require "states/sms_validation"
require "states/email_validation"
require "states/errors"
require "user"
require "context"

RSpec.describe States::SmsValidation do
  it "transitions user to SmsValidation state" do
    context = Context.new
    context.state = States::SmsValidation
    context.next_state
    expect(context.state).to eq(States::EmailValidation)
  end

  it "cannot send selfie" do
    context = User.new
    context.state = States::SmsValidation
    expect { context.send_selfie }.to raise_error(States::Errors::InvalidAction)
  end
end
