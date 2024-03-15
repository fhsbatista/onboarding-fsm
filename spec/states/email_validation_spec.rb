require "states/sms_validation"
require "states/email_validation"
require "states/errors"
require "user"

RSpec.describe States::EmailValidation do
  it "cannot transition to EmailValidation if there is no email address" do
    user = User.new(phone: "999 999", email: nil)
    expect { user.check_sms_token("1234") }.to raise_error(States::Errors::InvalidStateToTransition) { |e|
      expect(e.end_state).to eq(States::EmailValidation)
      expect(e.reason_type).to eq(:missing_field)
      expect(e.reason_value).to eq(:email)
    }
  end

  it "sends token on initialization" do
    user = User.new(phone: "999 999", email: "email@email.com")
    user.state = States::EmailValidation.new(user)
    expect(user.email_token).not_to eq(nil)
  end

  it "cannot send selfie" do
    user = User.new(phone: "999 999", email: "email@email.com")
    user.state = States::EmailValidation.new(user)
    expect { user.send_selfie }.to raise_error(States::Errors::InvalidEvent)
  end

  describe "check sms token" do
    it "transitions to SendSelfie state when token is valid" do
      user = User.new(phone: "999 999", email: "email@email.com")
      user.state = States::EmailValidation.new(user)
      user.check_email_token("1234")
      expect(user.state).to be_a(States::SendSelfie)
    end

    context "token NOT valid" do
      it "does not transition to SendSelfie" do
        user = User.new(phone: "999 999", email: "email@email.com")
        user.state = States::EmailValidation.new(user)
        user.check_email_token("#{1234}99")
        expect(user.state).to be_a(States::EmailValidation)
      end

      it "returns error" do
        user = User.new(phone: "999 999", email: "email@email.com")
        user.state = States::EmailValidation.new(user)
        error = user.check_email_token("#{1234}99")
        expect(error).to eq(:invalid_email_token)
      end
    end
  end
end
