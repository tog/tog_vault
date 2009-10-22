require_plugin 'tog_core'
require_plugin 'acts_as_tree'
require_plugin 'fckeditor'


Tog::Plugins.settings :tog_vault, :public_prefix => "cms"

Dir[File.dirname(__FILE__) + '/locale/**/*.yml'].each do |file|
  I18n.load_path << file
end

Tog::Plugins.helpers Vault::PageHelper

Tog::Interface.sections(:admin).add "CMS", "/admin/cms"

Tog::Search.sources << "Page"