module Users
  class Entity
    attr_accessor :phone, :sms_token, :email, :email_token, :document
    attr_reader :state

    def initialize(phone: nil, email: nil)
      @phone = phone
      @email = email
      @document = Users::Document.new(phone: @phone, email: @email, state: nil)
      @document.save
      transition_state(States::SmsValidation.new(self))
    end

    def transition_state(new_state)
      previous_state = @state
      @state = new_state
      states_map = {
        States::SmsValidation => :sms_validation,
        States::EmailValidation => :email_validation,
        States::SendSelfie => :send_selfie
      }
      @document.state = states_map[new_state.class]
      @document.save
      Users::TransitionLogs::Entity.new(previous_state:, current_state: @state, user: @document)
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

    def email_token
      @document.email_token
    end

    def transition_logs
      @document.transition_logs
    end
  end
end
