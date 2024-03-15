require "states/sms_validation"
require "states/email_validation"
require "states/errors"
require "user"

RSpec.describe States::SmsValidation do
  it "cannot transition to SmsValidation if there is no phone number" do
    expect { User.new(phone: nil) }.to raise_error(States::Errors::InvalidStateToTransition) { |e|
      expect(e.end_state).to eq(States::SmsValidation)
      expect(e.reason_type).to eq(:missing_field)
      expect(e.reason_value).to eq(:phone)
    }
  end

  it "sends token on initialization" do
    user = User.new(phone: "999 999")
    user.state = States::SmsValidation.new(user)
    expect(user.sms_token).not_to eq(nil)
  end

  it "cannot send selfie" do
    user = User.new(phone: "999 999")
    user.state = States::SmsValidation
    expect { user.send_selfie }.to raise_error(States::Errors::InvalidEvent)
  end

  describe "check sms token" do
    it "transitions to EmailValidation state when token is valid" do
      user = User.new(phone: "999 999", email: "email@email.com")
      user.check_sms_token("1234")
      expect(user.state).to be_a(States::EmailValidation)
    end

    context "token NOT valid" do
      it "does not transition to EmailValidation" do
        user = User.new(phone: "999 999")
        user.check_sms_token("#{1234}99")
        expect(user.state).to be_a(States::SmsValidation)
      end

      it "returns error" do
        user = User.new(phone: "999 999")
        error = user.check_sms_token("#{1234}99")
        expect(error).to eq(:invalid_sms_token)
      end
    end
  end
end
