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

class RoundRobinSettingController < ApplicationController
  #include RoundRobinSettingsHelper
  unloadable
  layout 'admin'

  before_filter :require_admin

  def index
    @groups = Group.includes(:group_round_robin, :users)

    respond_to do |format|
      format.html
    end
  end

  def reset
    @group_rr = GroupRoundRobin.where(:group_id => params[:id])[0]
    # reset the count
    @group_rr.last_user_id = 0
    
    respond_to do |format|
      if @group_rr.save
        format.html { redirect_to(round_robin_settings_url, :notice => "Group updated successfully.")}
      else
        format.html { redirect_to(round_robin_settings_url, :error => "Could not update group.")}
      end
    end
  end

  def activate
    @group_rr = GroupRoundRobin.where(:group_id => params[:id])[0]
    if @group_rr == nil
      # create the group_rr
      @group_rr = GroupRoundRobin.new(
          :group_id => params[:id],
          :is_active => true
        )
    elsif @group_rr.is_active == false
      @group_rr.is_active = true
    elsif @group_rr.is_active == true
      @group_rr.is_active = false
    end

    respond_to do |format|
      if @group_rr.save
        format.html { redirect_to(round_robin_settings_url, :notice => "Group updated successfully.")}
      else
        format.html { redirect_to(round_robin_settings_url, :error => "Could not update group.")}
      end
    end
  end
end
