module Ostiary
  module ControllerHelper

    def self.included(base)
      base.extend(ClassMethods)
    end

    module ClassMethods

      def inherited(subclass)
        subclass.ostiary.policies += self.ostiary.policies
        super
      end

      def ostiary
        @ostiary ||= Ostiary.new
      end

      def required_application_role(role, actions = {})
        warn "[DEPRECATION] `required_application_role` is deprecated.  Please use `ostiary_policy` instead."
        ostiary_policy(role, actions)
      end

      # We want to give the option of setting a policy for one action, based on ::Role
      # So we'll copy the way the filters in controllers work.
      # Only apply the role to certain action(s)
      #  only: [*actions]
      # Exclude action(s) from requiring a role
      #  except: [*actions]
      # By default a given role will be required for every action
      #
      # One line creates one policy, which are immediately created with the proper class
      def ostiary_policy(role, actions = {})
        if actions.empty?
          self.ostiary.policies << Policy.new(role)
        elsif actions.has_key?(:only)
          self.ostiary.policies << PolicyLimited.new(role, actions[:only])
        elsif actions.has_key?(:except)
          self.ostiary.policies << PolicyExempted.new(role, actions[:except])
        end
      end

    end

  end
end
