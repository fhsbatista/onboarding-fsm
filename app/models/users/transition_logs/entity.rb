module Users
  module TransitionLogs
    class Entity
      def initialize(previous_state:, current_state:, user:)
        @previous_state = previous_state
        @current_state = current_state
        @date_time = Time.zone.now
        @document = Users::TransitionLogs::Document.new
        @document.previous_state = symbol_from_state(previous_state)
        @document.current_state = symbol_from_state(current_state)
        @document.date_time = @date_time
        @document.user = user
        @document.save
      end

      private

      def symbol_from_state(state)
        states_map = {
          States::SmsValidation => :sms_validation,
          States::EmailValidation => :email_validation,
          States::SendSelfie => :send_selfie
        }
        states_map[state.class]
      end
    end
  end
end
