plugin 'fckeditor', :git => "git://github.com/molpe/fckeditor.git"
plugin 'acts_as_tree', :git => "git://github.com/rails/acts_as_tree.git"

plugin 'tog_vault', :git => "git://github.com/tog/tog_vault.git"

route "map.routes_from_plugin 'tog_vault'"

file "db/migrate/" + Time.now.strftime("%Y%m%d%H%M%S") + "_install_tog_vault.rb",
%q{class InstallTogVault < ActiveRecord::Migration
    def self.up
      migrate_plugin "tog_vault", 3
    end

    def self.down
      migrate_plugin "tog_vault", 0 
    end
end
}

rake "db:migrate"
rake "tog:plugins:copy_resources PLUGIN=tog_vault"
