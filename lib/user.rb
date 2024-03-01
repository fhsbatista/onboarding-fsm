class User
  attr_accessor :state

  def initialize
    @state = States::InitialData
  end

  def next_state
    state.next(self)
  end
end
