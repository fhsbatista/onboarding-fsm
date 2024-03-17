require "states/errors"

RSpec.describe States::Errors::InvalidStateToTransition do
  it "converts to string correctly" do
    error = States::Errors::InvalidStateToTransition.new(end_state: States::SmsValidation, reason_type: :missing_field, reason_value: :name)
    expect(error.to_s).to eq("Cannot transition to States::SmsValidation -- Reason type: missing_field, Reason value: name")
  end
end
