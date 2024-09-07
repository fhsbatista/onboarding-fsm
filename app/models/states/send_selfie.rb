module States
  class SendSelfie
    def initialize(context)
      @context = context
    end

    def send_selfie(base64)
      return :invalid_selfie unless Events::PersistSelfie.new(@context, base64).call
      
      @context.transition_state(States::Active.new(@context))
    end
  end
end
