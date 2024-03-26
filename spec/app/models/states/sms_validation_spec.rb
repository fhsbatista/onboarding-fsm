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
end
