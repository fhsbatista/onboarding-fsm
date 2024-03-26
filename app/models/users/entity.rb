module Users
  class Entity
    attr_accessor :phone, :sms_token, :email, :email_token
    attr_accessor :document
    attr_reader :state

    def initialize(phone: nil, email: nil)
      @phone = phone
      @email = email
      @document = Users::Document.new(phone: @phone, email: @email, state: nil)
      @document.save
      transition_state(States::SmsValidation.new(self))
    end

    def transition_state(new_state)
      @state = new_state
      states_map = {
        States::SmsValidation => :sms_validation,
        States::EmailValidation => :email_validation,
        States::SendSelfie => :send_selfie,
      }
      @document.state = states_map[new_state.class]
      @document.save
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

    def sms_token
      @document.sms_token
    end
  end
end
