# Round Robin - Redmine plugin
# Copyright (C) 2012 Paul Van de Vreede
#
# This file is part of Round Robin.
#
# Round Robin is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# Round Robin is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with Round Robin.  If not, see <http://www.gnu.org/licenses/>.

module RoundRobin
  module IssuePatch
    def self.included(base)
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
        RoundRobin.log_debug "Running round robin before save filter."
        # ignore items without an assignee
        return if self.assigned_to_id == nil
        # ignore items that are assigned to a user type
        return if self.assigned_to.type == "User"
        # if there are no items in the rr table then ignore
        group_rr = GroupRoundRobin.where(:group_id => self.assigned_to_id) \
                                  .where(:is_active => true)[0]
        return if group_rr == nil
        RoundRobin.log_debug "Round robin is: #{group_rr.attributes.inspect}"
        if not group_rr.is_weighted
          # for normal round robin use the last user field
          next_user_id = get_round_robin_assignee group_rr.group_id, (group_rr.last_user_id || 0)
          self.assigned_to_id = next_user_id
          group_rr.last_user_id = next_user_id
          group_rr.save
        else
          # for weighted round robin, just get the person in the group with the least issues
          # TBD
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

      def get_weighted_round_robin_assignee(group_id)
        
      end

    end

  end

end

Issue.send(:include, RoundRobin::IssuePatch)