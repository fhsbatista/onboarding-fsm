module States
  module Errors
    class InvalidEvent < StandardError; end
    class InvalidStateToTransition < StandardError
      attr_reader :reason_type, :reason_value

      def initialize(reason_type:, reason_value:)
        @reason_type = reason_type
        @reason_value = reason_value
      end
    end
  end
end
