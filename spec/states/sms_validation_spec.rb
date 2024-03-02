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

  it "cannot transition to SmsValidation if there is no phone number" do
    context = User.new
    context.state = States::InitialData
    expect { context.next_state }.to raise_error(States::Errors::InvalidStateToTransition)
  end

  it "can send token to sms validaiton" do
    context = User.new
    context.state = States::SmsValidation
    context.send_sms_token
    expect(context.sms_token).not_to eq(nil)
  end

  it "cannot send selfie" do
    context = User.new
    context.state = States::SmsValidation
    expect { context.send_selfie }.to raise_error(States::Errors::InvalidAction)
  end
end
