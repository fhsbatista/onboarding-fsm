class TransitionLog
  attr_reader :previous_state, :current_state

  def initialize(previous_state:, current_state:)
    @previous_state = previous_state
    @current_state = current_state
  end

end