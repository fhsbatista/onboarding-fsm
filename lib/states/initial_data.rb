module States
  class InitialData
    def self.next(context)
      context.state = States::SmsValidation
    end
  end
end