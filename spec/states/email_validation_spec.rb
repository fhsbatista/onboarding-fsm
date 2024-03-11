require "states/sms_validation"
require "states/email_validation"
require "states/errors"
require "user"

RSpec.describe States::EmailValidation do
  it "cannot transition to EmailValidation if there is no email address" do
    user = User.new(phone: '999 999', email: nil)
    expect { user.check_sms_token('1234') }.to raise_error(States::Errors::InvalidStateToTransition)
  end

  it "sends token on initialization" do
    user = User.new(phone: '999 999', email: 'email@email.com')
    user.state = States::EmailValidation.new(user)
    expect(user.email_token).not_to eq(nil)
  end
end
