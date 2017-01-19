module Ostiary
  class PolicyExempted < Policy

    def inspect
      "#{name} except for #{rules.to_sentence}"
    end

    def met?(action)
      return true if rules.include?(action)
      yield
    end

    def error_message(action)
      "#{action} not exempted for #{name}"
    end

  end
end
