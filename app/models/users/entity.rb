module Users
  class Entity
    attr_reader :phone,
                :sms_token,
                :email,
                :email_token,
                :document,
                :selfie
    attr_accessor :state

    private_class_method :new

    def initialize(document:, phone: nil, email: nil, selfie: nil, state: nil)
      @phone = phone
      @email = email
      @selfie = selfie
      @state = state
      @document = document
    end

    def self.create(phone: nil, email: nil)
      document = Users::Document.new(phone:, email:, state: nil)
      document.save
      user = new(phone:, email:, document:, state: nil)
      user.state = States::Initial.new(user)
      user.transition_state(States::SmsValidation.new(user))
      user
    rescue StandardError => e
      user.document.destroy
      raise e
    end

    def self.find(email)
      document = Users::Document.where(email:).first
      user = new(email: document.email, phone: document.phone, selfie: document.selfie, document:)
      state_type = Users::TransitionState::STATES_MAP.key(document.state.to_sym)
      user.state = state_type.new(user)
      user
    end

    def transition_state(new_state)
      Users::TransitionState.new(self, new_state).call
    end

    def check_sms_token(token)
      return %i[error invalid_action] unless @state.respond_to? :check_sms_token

      @state.check_sms_token(token)
    end

    def check_email_token(token)
      return %i[error invalid_action] unless @state.respond_to? :check_email_token

      @state.check_email_token(token)
    end

    def send_selfie(base64)
      return %i[error invalid_action] unless @state.respond_to? :send_selfie

      @state.send_selfie(base64)
    end

    def transition_logs
      @document.transition_logs
    end
  end
end
