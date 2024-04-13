module States
  module Events
    class CheckSmsToken
      def initialize(user, token)
        @user = user
        @token = token
      end

      def call
        @token == @user.document.sms_token
      end
    end
  end
end
