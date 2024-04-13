module States
  module Events
    class CheckEmailToken
      def initialize(user, token)
        @user = user
        @token = token
      end

      def call
        @token == @user.document.email_token
      end
    end
  end
end
