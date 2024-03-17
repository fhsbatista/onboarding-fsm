class TransitionLog
  attr_reader :previous_state, :current_state, :date_time

  def initialize(previous_state:, current_state:)
    @previous_state = previous_state
    @current_state = current_state
    @date_time = Time.now
  end

end