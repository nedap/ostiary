module Ostiary
  class Policy
    attr_reader :name, :method, :actions

    def initialize(name, actions = [], method: nil)
      @name = name
      @method = method
      @actions = actions
    end

    def inspect
      "#{name}"
    end

    def met?(_action, &block)
      return yield name unless method
      method.call
    end

    def error_message(action)
      "#{action} requires #{name}"
    end

  end
end
