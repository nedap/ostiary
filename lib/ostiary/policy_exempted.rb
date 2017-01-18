module Ostiary
  class PolicyExempted < Policy

    def inspect
      "#{role} except #{rules.to_sentence}"
    end

    def met?(action)
      return true if rules.include?(action)
      yield
    end

    def error_message(action)
      "#{action} not exempted for #{role} role"
    end

  end
end
