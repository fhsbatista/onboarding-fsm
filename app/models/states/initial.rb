require_relative 'errors'

module States
  class Initial
    def initialize(context)
      if context.phone.blank?
        raise States::Errors::InvalidStateToTransition.new(end_state: self.class,
                                                           reason_type: :missing_field,
                                                           reason_value: :phone)
      end

      if context.email.blank?
        raise States::Errors::InvalidStateToTransition.new(end_state: self.class,
                                                           reason_type: :missing_field,
                                                           reason_value: :email)
      end

      @context = context
    end
  end
end
