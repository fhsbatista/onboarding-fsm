module States
  class EmailValidation
    def initialize(context)
      raise States::Errors::InvalidStateToTransition if context.email.nil?
      @context = context
      send_email_token
    end

    def check_email_token(token)
      return :invalid_email_token unless token == @context.email_token
    end

    private

    def send_email_token
      @context.email_token = "1234"
    end
  end
end
