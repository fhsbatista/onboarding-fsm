require "states/initial_data"
require "states/errors"
require "transition"

class User
  attr_accessor :state, :phone
  attr_reader :sms_token

  def initialize
    @state = States::InitialData
  end

  def next_state
    start_state = @state
    end_state = state.next(self)
    Transition.new(
      context: self,
      start_state: start_state,
      end_state: end_state,
      time: Time.now,
    )
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
