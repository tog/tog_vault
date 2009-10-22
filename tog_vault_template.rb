plugin 'fckeditor', :git => "git://github.com/molpe/fckeditor.git"
plugin 'acts_as_tree', :git => "git://github.com/rails/acts_as_tree.git"

plugin 'tog_vault', :git => "git://github.com/tog/tog_vault.git"

route "map.routes_from_plugin 'tog_vault'"

generate "update_tog_migration"

rake "db:migrate"
rake "tog:plugins:copy_resources PLUGIN=tog_vault"
