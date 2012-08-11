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

class CreateGroupRoundRobins < ActiveRecord::Migration
  def change
    create_table :group_round_robins do |t|
    	t.integer :group_id, :null => false
    	t.boolean :is_active, :null => false, :default => false
    	t.boolean :is_weighted, :null => false, :default => false
    	t.integer :last_user_id, :null => true

      t.timestamps
    end
  end
end
