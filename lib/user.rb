require 'context'
require 'states/initial_data'
require 'states/errors'

class User < Context
  attr_accessor :state
  attr_reader :sms_token

  def initialize
    @state = States::InitialData
  end

  def send_sms_token
    @sms_token = '1234'
  end

  def send_selfie
    raise States::Errors::InvalidAction
  end
end
