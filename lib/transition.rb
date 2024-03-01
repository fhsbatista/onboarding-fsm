class Transition
  def initialize(context:, start_state:, end_state:, time:)
    @context = context
    @start_state = start_state
    @end_state = end_state
    @time = Time.at(time.to_i)
  end
end