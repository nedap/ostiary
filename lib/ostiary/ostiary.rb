module Ostiary
  class Ostiary
    attr_accessor :policies

    def initialize
      @policies = []
    end

    def authorize!(action, &block)
      policies.each do |policy|
        next if policy.met?(action, &block)
        raise PolicyBroken, policy.error_message(action)
      end
    end

    def authorized?(action, &block)
      policies.all? do |policy|
        policy.met?(action, block)
      end
    end

  end
end
