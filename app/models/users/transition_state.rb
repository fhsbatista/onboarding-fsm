module Users
  class TransitionState
    STATES_MAP = {
      States::SmsValidation => :sms_validation,
      States::EmailValidation => :email_validation,
      States::SendSelfie => :send_selfie,
      States::Active => :active
    }.freeze

    def initialize(user, new_state)
      @user = user
      @previous_state = @user.state
      @new_state = new_state
    end

    def call
      @user.state = @new_state
      @user.document.state = STATES_MAP[@new_state.class]
      @user.document.save
      Users::TransitionLogs::Entity.new(previous_state: @previous_state,
                                        current_state: @new_state,
                                        user: @user.document)
    end
  end
end
