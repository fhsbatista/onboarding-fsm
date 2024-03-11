require "states/errors"
require "states/sms_validation"

class User
  attr_accessor :state, :phone
  attr_reader :sms_token

  def initialize
    @state = States::SmsValidation
  end

  def send_sms_token
    @sms_token = "1234"
  end

  def check_sms_token(token)
    @state.check_sms_token(self, token)
  end

  def send_selfie
    raise States::Errors::InvalidAction
  end
end
