module States
  module Events
    class SendSmsToken
      def initialize(user)
        @user = user
      end

      def call
        @user.document.sms_token = '1234'
        @user.document.save
      end
    end
  end
end
