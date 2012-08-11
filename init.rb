require_dependency "issue_patch"

Redmine::Plugin.register :round_robin do
  name 'Round Robin plugin'
  author 'Paul Van de Vreede'
  description 'Assignment to users in a group via round robin.'
  version '0.9.0'
  url 'https://github.com/pvdvreede/round_robin'
  author_url 'https://github.com/pvdvreede'
end
