module Ostiary
  class PolicyExempted < Policy

    def inspect
      "#{name} except for #{actions.to_sentence}"
    end

    def met?(action)
      return true if actions.include?(action)
      super
    end

    def error_message(action)
      "#{action} not exempted for #{name}"
    end

  end
end
