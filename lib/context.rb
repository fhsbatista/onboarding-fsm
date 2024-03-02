require 'transition'
class Context
  attr_accessor :state, :phone

  def next_state
    start_state = @state
    end_state = state.next(self)
    Transition.new(
      context: self,
      start_state: start_state,
      end_state: end_state,
      time: Time.now,
    )
  end
end
