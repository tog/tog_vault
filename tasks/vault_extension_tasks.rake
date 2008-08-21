namespace :tog do
  namespace :extensions do
    namespace :vault do
      
      desc "Runs the migration of the Vault CMS extension"
      task :migrate => :environment do
        require 'tog/extension_migrator'
        if ENV["VERSION"]
          VaultExtension.migrator.migrate(ENV["VERSION"].to_i)
        else
          VaultExtension.migrator.migrate
        end
      end
      
      desc "Copy Vault js files to Tog"
      task :update => :environment do
        FileUtils.cp_r VaultExtension.root + "/public/javascripts/", RAILS_ROOT + "/public/javascripts/vault"
        FileUtils.cp_r VaultExtension.root + "/public/images/", RAILS_ROOT + "/public/images/vault"
      end
    
    end
  end
end          