require_relative "email_validation"
require_relative "errors"
module States
  class SmsValidation
    def initialize(context)
      raise States::Errors::InvalidStateToTransition if context.phone.nil?
    end

    def self.next(context)
      context.state = States::EmailValidation
    end
  end
end