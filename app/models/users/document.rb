module Users
  class Document
    include Mongoid::Document
    extend Enumerize

    field :phone
    field :email
    field :sms_token
    field :email_token
    field :state
    enumerize :state, in: [:sms_validation, :email_validation, :send_selfie], default: nil
  end
end
