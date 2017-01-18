module Ostiary
  class PolicyLimited < Policy

    def inspect
      "#{role} only for #{rules.to_sentence}"
    end

    def met?(action)
      return true if !rules.include?(action)
      yield
    end

    def error_message(action)
      "#{action} limited by #{role} role"
    end

  end
end
