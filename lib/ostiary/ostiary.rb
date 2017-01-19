module Ostiary
  class Ostiary
    attr_accessor :policies

    def initialize
      @policies = []
    end

    def authorize!(action)
      policies.each do |policy|
        next if policy_met?(policy, action, &Proc.new)
        raise PolicyBroken, policy.error_message(action)
      end
    end

    def authorized?(action)
      policies.all? do |policy|
        policy_met?(policy, action, &Proc.new)
      end
    end

    private

    def policy_met?(policy, action)
      policy.met?(action) { yield(policy.name) }
    end

  end
end
