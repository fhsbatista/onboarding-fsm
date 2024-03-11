require_relative "email_validation"
require_relative "errors"

module States
  class SmsValidation
    def initialize(context)
      raise States::Errors::InvalidStateToTransition if context.phone.nil?
      send_sms_token(context)
    end

    def self.next(context)
      context.state = States::EmailValidation
    end

    def self.check_sms_token(context, token)
      context.state = States::EmailValidation if token == context.sms_token
    end

    private

    def send_sms_token(context)
      context.sms_token = "1234"
    end
  end
end
