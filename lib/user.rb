require "states/errors"
require "states/sms_validation"

class User
  attr_accessor :state, :transitions_logs, :phone, :sms_token, :email, :email_token

  def initialize(phone: nil, email: nil)
    @phone = phone
    @email = email
    @state = States::SmsValidation.new(self)
    @transitions_logs = []
  end

  def check_sms_token(token)
    @state.check_sms_token(token)
  end

  def check_email_token(token)
    @state.check_email_token(token)
  end

  def send_selfie
    raise States::Errors::InvalidEvent
  end
end
