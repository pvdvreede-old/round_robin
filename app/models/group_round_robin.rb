class GroupRoundRobin < ActiveRecord::Base
  unloadable

  belongs_to :group
  belongs_to :user, :though => :last_user
end
