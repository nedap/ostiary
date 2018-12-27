module Ostiary
  class Policy
    attr_reader :name, :actions

    def initialize(name, actions = [])
      @name = name
      @actions = actions
    end

    def inspect
      "#{name}"
    end

    def met?(_action)
      yield name
    end

    def error_message(action)
      "#{action} requires #{name}"
    end

  end
end
