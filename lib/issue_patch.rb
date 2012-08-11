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
        # if there are no items in the rr table then ignore
        group_rr = GroupRoundRobin.where(:group_id => self.assigned_to_id)
                                  .where(:is_active => true)[0]
        return if group_rr == nil
        if not group_rr.is_weighted
          next_user_id = get_round_robin_assignee group_rr.group_id, group_rr.last_user_id
          self.assigned_to_id = next_user_id
          group_rr.last_user_id = next_user_id
        end
      end

      def get_round_robin_assignee(group_id, last_id)
        users = Group.find(group_id).users.order("id")
        user_count = users.count
        return if user_count == 0
        return users[0].id if user_count == 1
        return users[0].id if last_id == 0 
        users.each_with_index do |u, i|
          if u.id == last_id
            if i+1 == user_count
              return users[0].id
            else
              return users[i+1].id
            end
          end
        end
      end

    end

  end

end

Issue.send(:include, RoundRobin::IssuePatch)