require "rails_helper"

RSpec.describe States::EmailValidation do
  it "cannot transition to EmailValidation if there is no email address" do
    user = Users::Entity.new(phone: "999 999", email: nil)
    expect { user.check_sms_token("1234") }.to raise_error(States::Errors::InvalidStateToTransition) { |e|
      expect(e.end_state).to eq(States::EmailValidation)
      expect(e.reason_type).to eq(:missing_field)
      expect(e.reason_value).to eq(:email)
    }
  end
end
