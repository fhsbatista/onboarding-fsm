module States
  module Events
    class PersistSelfie
      def initialize(user, base64)
        @user = user
        @base64 = base64
      end

      def call
        return false unless valid?

        @user.document.selfie = @base64
      end

      private

      def valid?
        @base64.present?
      end
    end
  end
end
