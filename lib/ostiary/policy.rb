module Ostiary
  class Policy
    attr_accessor :name, :rules

    def initialize(name, rules = [])
      @name   = name
      @rules  = rules || []
    end

    def inspect
      "#{name}"
    end

    def met?(*)
      yield
    end

    def error_message(action)
      "#{action} requires #{name}"
    end

  end
end
