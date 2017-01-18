module Ostiary
  class Policy
    attr_accessor :role, :rules

    def initialize(role, rules = [])
      @role   = role
      @rules  = rules || []
    end

    def inspect
      "#{role}"
    end

    def met?(*)
      yield
    end

    def error_message(action)
      "#{action} requires #{role} role"
    end

  end
end
