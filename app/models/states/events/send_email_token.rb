module States
  module Events
    class SendEmailToken
      def initialize(user)
        @user = user
      end

      def call
        @user.document.email_token = '1234'
        @user.document.save
      end
    end
  end
end
