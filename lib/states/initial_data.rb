require_relative 'sms_validation'

module States
  class InitialData
    def self.next(context)
      context.state = States::SmsValidation.new(context)
    end
  end
end