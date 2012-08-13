# Round Robin - Redmine plugin

## Redmine plugin to auto assign to members on group assignment via round robin.

This plugin can be used to auto assign issues that were originally assigned to a group to the people in the group, using round robin. This means every person inside the group will receive an issue one after the other.

### Requirements

This plugin requires Redmine 2.0.0 or higher. It is not compatible with Redmine 1.x.

### Installation

To install the plugin, just download the code and put the round robin folder into the plugins directory. Run the rake migrate command for plugins with:

    rake redmine:plugins:migrate

Then restart the web server, and a new Round Robin menu option should appear under the administration menu.

This menu will show you all the groups that have been created on the system, with the option to activate the round robin functionality on the right side of the list. Clicking this activate link will enable the round robin functionality and from then on, any issue that is assigned to the group will then get re-assigned to the people in the group.

**Note that you will only be able to assign to groups in Redmine if you enable the setting `Allow issue assignment to groups` under `Administration > Settings > Issue Tracking`.**

### License

The Round Robin plugin is license under the GNU GPLv3 and is freely available to use.

Pull Requests are welcomed.