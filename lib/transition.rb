class Transition
  attr_reader :context, :start_state, :end_state, :time

  def initialize(context:, start_state:, end_state:, time:)
    @context = context
    @start_state = start_state
    @end_state = end_state
    @time = Time.at(time.to_i)
  end

  def ==(other)
    self.context == other.context &&
    self.start_state == other.start_state &&
    self.end_state == other.end_state &&
    self.time == other.time
  end
end
