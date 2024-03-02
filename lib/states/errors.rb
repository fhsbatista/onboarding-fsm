module States
  module Errors
    class InvalidAction < StandardError; end
    class InvalidStateToTransition < StandardError; end
  end
end
