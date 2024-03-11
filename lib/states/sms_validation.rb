require_relative "email_validation"
require_relative "errors"

module States
  class SmsValidation
    def initialize(context)
      raise States::Errors::InvalidStateToTransition if context.phone.nil?
      @context = context
      send_sms_token
    end

    def check_sms_token(token)
      return :invalid_sms_token unless token == @context.sms_token
      @context.state = States::EmailValidation
    end

    private

    def send_sms_token
      @context.sms_token = "1234"
    end
  end
end
