module Users
  class Document
    include Mongoid::Document
    extend Enumerize

    field :phone
    field :email
    field :sms_token
    field :email_token
    has_many :transition_logs, class_name: 'Users::TransitionLogs::Document'

    field :state
    enumerize :state, in: %i[sms_validation email_validation send_selfie], default: nil
  end
end
