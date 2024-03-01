require 'context'
require 'states/initial_data'
require 'states/errors'

class User < Context
  attr_accessor :state

  def initialize
    @state = States::InitialData
  end

  def send_selfie
    raise States::Errors::InvalidAction
  end
end
