module States
  module Errors
    class InvalidEvent < StandardError; end
    class InvalidStateToTransition < StandardError; end
  end
end
