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

require File.dirname(File.expand_path(__FILE__)) + '/../test_helper'

class IssuePatchTest < ActiveSupport::TestCase
  self.fixture_path = File.dirname(__FILE__) + "/../fixtures/"
  fixtures :all

  def test_assign_user_unaffected
    # save as a user and make sure its the same
    issue = create_issue 1
    assert_equal 1, issue.assigned_to_id
  end

  def test_round_robin_when_non_existent
    # save an issue to the group not active and check it stays the same
    issue = create_issue 11
    assert_equal 11, issue.assigned_to_id, "Group assigned is being changed when no rr row."
  end

  def test_round_robin_when_disabled
    # save an issue with a group that is in the db but inactive
    issue = create_issue 12
    assert_equal 12, issue.assigned_to_id, "Inactive group is being round robined"
  end

  def test_round_robin_when_active_with_three
    # save an issue make sure its the first in the group (by id)
    i1 = create_issue 10
    rr = GroupRoundRobin.where(:group_id => 10)[0]
    assert_equal 1, rr.last_user_id, "Group round robin record didnt get updated"
    assert_equal 1, i1.assigned_to_id, "First user wasnt assigned properly"
    # save a second issue and make sure its the second in the group
    i2 = create_issue 10
    rr = GroupRoundRobin.where(:group_id => 10)[0]
    assert_equal 2, rr.last_user_id, "Group round robin record didnt get updated"
    assert_equal 2, i2.assigned_to_id, "Second user wasnt assigned properly"
    # save a third issue and make sure its the third in the group
    i3 = create_issue 10
    rr = GroupRoundRobin.where(:group_id => 10)[0]
    assert_equal 3, rr.last_user_id, "Group round robin record didnt get updated"
    assert_equal 3, i3.assigned_to_id, "Third user wasnt assigned properly"
    # save a fourth issue and make sure its the first one again
    i4 = create_issue 10
    rr = GroupRoundRobin.where(:group_id => 10)[0]
    assert_equal 1, rr.last_user_id, "Group round robin record didnt get updated"
    assert_equal 1, i4.assigned_to_id, "Fourth user wasnt looped back to the first in the group"
  end

  private
  def create_issue(assigned_to_id)
    i = Issue.new(
  	 :subject => "Test item",
  	 :tracker_id => 3,
  	 :project_id => 1,
  	 :assigned_to_id => assigned_to_id,
     :author_id => 1
    )

    if not i.save
      raise "Could not save issue:\n#{i.errors.full_messages.join("\n")}"
    end
    i
  end

end
