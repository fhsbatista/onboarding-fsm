require "states/initial_data"
require "states/sms_validation"
require "user"

RSpec.describe States::InitialData do
  it "transitions user to SmsValidation state" do
    user = User.new
    user.state = States::InitialData
    user.phone = '111 991 999'
    user.next_state
    expect(user.state).to be_an_instance_of(States::SmsValidation)
  end
end
