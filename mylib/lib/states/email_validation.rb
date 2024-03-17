require_relative "send_selfie"

module States
  class EmailValidation
    def initialize(context)
      raise States::Errors::InvalidStateToTransition.new(end_state: self.class, reason_type: :missing_field, reason_value: :email) if context.email.nil?
      @context = context
      send_email_token
    end

    def check_email_token(token)
      return :invalid_email_token unless token == @context.email_token
      @context.transition_state(States::SendSelfie.new(@context))
    end

    private

    def send_email_token
      @context.email_token = "1234"
    end
  end
end