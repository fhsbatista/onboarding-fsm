require_relative 'email_validation'
require_relative 'errors'

module States
  class SmsValidation
    def initialize(context)
      if context.phone.nil?
        raise States::Errors::InvalidStateToTransition.new(end_state: self.class, reason_type: :missing_field,
                                                           reason_value: :phone)
      end

      @context = context
      send_sms_token
    end

    def check_sms_token(token)
      return :invalid_sms_token unless token == @context.document.sms_token

      @context.transition_state(States::EmailValidation.new(@context))
    end

    private

    def send_sms_token
      @context.document.sms_token = '1234'
      @context.document.save
    end
  end
end
