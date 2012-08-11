class GroupRoundRobin < ActiveRecord::Base
  unloadable

  belongs_to :group
  has_one :user, :through => :last_user_id
end
