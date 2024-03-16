class TransitionLog
  attr_reader :previous_state

  def initialize(previous_state:)
    @previous_state = previous_state
  end

end