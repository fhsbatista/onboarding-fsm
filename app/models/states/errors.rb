module States
  module Errors
    class InvalidEvent < StandardError; end

    class InvalidStateToTransition < StandardError
      attr_reader :end_state, :reason_type, :reason_value

      def initialize(end_state:, reason_type:, reason_value:)
        @end_state = end_state
        @reason_type = reason_type
        @reason_value = reason_value
        super
      end

      def to_s
        "Cannot transition to #{@end_state} -- Reason type: #{@reason_type}, Reason value: #{@reason_value}"
      end
    end
  end
end
