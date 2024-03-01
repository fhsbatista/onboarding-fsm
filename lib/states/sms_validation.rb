module States
  class SmsValidation
    def self.next(context)
      context.state = States::EmailValidation
    end
  end
end