require "rails_helper"

RSpec.describe Users::Entity do
  context "on initialization" do
    it "state should be SmsValidation" do
      user = Users::Entity.new(phone: "999 999")
      expect(user.state).to be_a(States::SmsValidation)
    end
  end
end