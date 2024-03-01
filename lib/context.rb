class Context
  attr_accessor :state

  def next_state
    state.next(self)
  end
end