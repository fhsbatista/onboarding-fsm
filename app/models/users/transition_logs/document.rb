module Users
  module TransitionLogs
    class Document
      include Mongoid::Document
      extend Enumerize

      belongs_to :user, class_name: 'Users::Document'

      field :previous_state
      enumerize :previous_state, in: [:sms_validation, :email_validation, :send_selfie], default: nil
      
      field :current_state
      enumerize :current_state, in: [:sms_validation, :email_validation, :send_selfie], default: nil

      field :date_time, type: DateTime
    end
  end
end
