require_plugin 'tog_core'
require_plugin 'acts_as_taggable_on_steroids'
require_plugin 'acts_as_tree'
require_plugin 'acts_as_state_machine'

Tog::Plugins.settings :tog_vault, :public_prefix => "cms"

Tog::Interface.sections(:admin).add "CMS", "/admin/cms"