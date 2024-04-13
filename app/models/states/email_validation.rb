require_relative 'send_selfie'

module States
  class EmailValidation
    def initialize(context)
      if context.email.nil?
        raise States::Errors::InvalidStateToTransition.new(end_state: self.class, reason_type: :missing_field,
                                                           reason_value: :email)
      end

      @context = context
      Events::SendEmailToken.new(@context).call
    end

    def check_email_token(token)
      return :invalid_email_token unless Events::CheckEmailToken.new(@context, token).call

      @context.transition_state(States::SendSelfie.new(@context))
    end
  end
end
