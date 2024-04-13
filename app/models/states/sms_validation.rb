require_relative 'email_validation'
require_relative 'errors'
require_relative 'events/send_sms_token'

module States
  class SmsValidation
    def initialize(context)
      if context.phone.nil?
        raise States::Errors::InvalidStateToTransition.new(end_state: self.class, reason_type: :missing_field,
                                                           reason_value: :phone)
      end

      @context = context
      Events::SendSmsToken.new(context).call
    end

    def check_sms_token(token)
      return :invalid_sms_token unless Events::CheckSmsToken.new(@context, token).call

      @context.transition_state(States::EmailValidation.new(@context))
    end
  end
end
