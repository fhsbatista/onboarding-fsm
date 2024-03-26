require "rails_helper"

RSpec.describe States::SmsValidation do
  it "cannot transition to Smsvalidation if there is no phone number" do
    expect { Users::Entity.new(phone: nil) }.to raise_error(States::Errors::InvalidStateToTransition) { |e|
      expect(e.end_state).to eq(States::SmsValidation)
      expect(e.reason_type).to eq(:missing_field)
      expect(e.reason_value).to eq(:phone)
    }
  end

end
