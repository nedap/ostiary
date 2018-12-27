module Ostiary
  class Ostiary
    attr_accessor :policies

    def initialize
      @policies = []
    end

    def authorize!(action, &block)
      policies.each do |policy|
        next if policy_met?(policy, action, block)
        raise PolicyBroken, policy.error_message(action)
      end
    end

    def authorized?(action, &block)
      policies.all? do |policy|
        policy_met?(policy, action, block)
      end
    end

    private

    def policy_met?(policy, action, &block)
      policy.met?(action) { yield policy.name }
    end

  end
end
