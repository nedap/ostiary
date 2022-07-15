module Ostiary
  class PolicyLimited < Policy

    def inspect
      "#{name} only for #{actions.to_sentence}"
    end

    def met?(action, &block)
      return true unless actions.include?(action)
      super
    end

    def error_message(action)
      "#{action} limited by #{name}"
    end

  end
end
