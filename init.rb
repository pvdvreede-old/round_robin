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

require_dependency "round_robin_issue_patch"
require_dependency "round_robin_group_patch"

Redmine::Plugin.register :round_robin do
  name 'Round Robin plugin'
  author 'Paul Van de Vreede'
  description 'Assignment to users in a group via round robin.'
  version '1.0.0'
  url 'https://github.com/pvdvreede/round_robin'
  author_url 'https://github.com/pvdvreede'

  # add menu item for settings in Admin menu
  menu :admin_menu, \
       :round_robin_settings, \
       {:controller => :round_robin_setting, :action => :index}, \
       :caption => "Round Robin", \
       :html => { :class => "groups" }
end

module RoundRobin
  def self.log_debug(msg)
    Rails.logger.debug "DEBUG RoundRobin - #{msg}"
  end
end
