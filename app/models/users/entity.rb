module Users
  class Entity
    attr_reader :phone,
                :sms_token,
                :email,
                :email_token,
                :document
    attr_accessor :state

    def initialize(phone: nil, email: nil)
      @phone = phone
      @email = email
      @state = States::Initial.new(self)
      @document = Users::Document.new(phone: @phone, email: @email, state: @state)
      @document.save
      transition_state(States::SmsValidation.new(self))
    end

    def transition_state(new_state)
      Users::TransitionState.new(self, new_state).call
    end

    def check_sms_token(token)
      @state.check_sms_token(token)
    end

    def check_email_token(token)
      @state.check_email_token(token)
    end

    def send_selfie
      raise States::Errors::InvalidEvent
    end

    def transition_logs
      @document.transition_logs
    end
  end
end
