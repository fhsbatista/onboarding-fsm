require "rails_helper"

RSpec.describe States::SmsValidation do
  it "cannot transition to Smsvalidation if there is no phone number" do
    expect { Users::Entity.new(phone: nil) }.to raise_error(States::Errors::InvalidStateToTransition) { |e|
      expect(e.end_state).to eq(States::SmsValidation)
      expect(e.reason_type).to eq(:missing_field)
      expect(e.reason_value).to eq(:phone)
    }
  end

  it "sends token on initialization" do
    user = Users::Entity.new(phone: "999 999")
    expect(user.sms_token).not_to eq(nil)
  end

  it "cannot send selfie" do
    user = Users::Entity.new(phone: "999 999")
    user.transition_state(States::SmsValidation)
    expect { user.send_selfie }.to raise_error(States::Errors::InvalidEvent)
  end

  describe "check sms token" do
    it "transitions to EmailValidation state when token is valid" do
      user = Users::Entity.new(phone: "999 999", email: "email@email.com")
      valid_token = user.sms_token
      user.check_sms_token(valid_token)
      expect(user.state).to be_a(States::EmailValidation)
    end

    context "token NOT valid" do
      it "does not transition to EmailValidation" do
        user = Users::Entity.new(phone: "999 999")
        valid_token = user.sms_token
        user.check_sms_token("#{valid_token}99")
        expect(user.state).to be_a(States::SmsValidation)
      end

      it "returns error" do
        user = Users::Entity.new(phone: "999 999")
        valid_token = user.sms_token
        error = user.check_sms_token("#{valid_token}99")
        expect(error).to eq(:invalid_sms_token)
      end
    end
  end
end
