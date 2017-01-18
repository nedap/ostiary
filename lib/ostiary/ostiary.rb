module Ostiary
  class Ostiary
    attr_accessor :policies

    def initialize
      @policies = []
    end

    def authorize!(action)
      policies.all? do |policy|
        assert_policy!(policy, action, &Proc.new)
      end
    end

    def authorized?(action)
      policies.all? do |policy|
        policy.met?(action) { yield(policy.role) }
      end
    end

    def assert_policy!(policy, action)
      return true if policy.met?(action) do
        yield(policy.role)
      end
      raise PolicyBroken, policy.error_message(action)
    end

  end
end
