require "states/sms_validation"
require "states/email_validation"
require "states/errors"
require "user"

RSpec.describe States::SmsValidation do
  it "transitions user to SmsValidation state" do
    user = User.new
    user.state = States::SmsValidation
    user.next_state
    expect(user.state).to eq(States::EmailValidation)
  end

  it "cannot transition to SmsValidation if there is no phone number" do
    user = User.new
    user.state = States::InitialData
    expect { user.next_state }.to raise_error(States::Errors::InvalidStateToTransition)
  end

  it "can send token to sms validaiton" do
    user = User.new
    user.state = States::SmsValidation
    user.send_sms_token
    expect(user.sms_token).not_to eq(nil)
  end

  it "cannot send selfie" do
    user = User.new
    user.state = States::SmsValidation
    expect { user.send_selfie }.to raise_error(States::Errors::InvalidAction)
  end
end
