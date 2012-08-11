module RoundRobin
  module IssuePatch
    def self.include(base)
      base.extend(ClassMethods)
      base.send(:include, InstanceMethods)
      base.class_eval do
        unloadable

        # add before save filter to change the user if a group
        before_save :round_robin_assign

      end
    end

    module ClassMethods
    end

    module InstanceMethods

      def round_robin_assign
        # ignore items without an assignee
        return if self.assigned_to_id == nil
        # ignore items that are assigned to a user type
        return if self.assigned_to.type == "User"

      end

    end

  end

end

Issue.send(:include, RoundRobin::IssuePatch)