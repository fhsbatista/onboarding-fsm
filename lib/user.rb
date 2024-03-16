require "states/errors"
require "states/sms_validation"
require "transition_log"

class User
  attr_accessor :transitions_logs, :phone, :sms_token, :email, :email_token
  attr_reader :state

  def initialize(phone: nil, email: nil)
    @phone = phone
    @email = email
    @transitions_logs = []
    transition_state(States::SmsValidation.new(self))
  end

  def transition_state(new_state)
    @state = new_state
    @transitions_logs << TransitionLog.new
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
