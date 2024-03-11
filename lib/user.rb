require "states/errors"
require "states/sms_validation"

class User
  attr_accessor :state, :phone, :sms_token
  
  def initialize(phone:)
    @phone = phone
    @state = States::SmsValidation.new(self)
  end

  def check_sms_token(token)
    @state.check_sms_token(token)
  end

  def send_selfie
    raise States::Errors::InvalidAction
  end
end
