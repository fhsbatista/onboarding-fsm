require 'context'
class User < Context
  attr_accessor :state

  def initialize
    @state = States::InitialData
  end
end
