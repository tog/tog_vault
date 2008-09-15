Vault
=====

A small CMS for your website static pages!


Resources
=========

Plugin requirements
-------------------

In case you haven't installed any of them previously you'll need the following plugins:

* [acts\_as\_taggable\_on\_steroids](https://github.com/tog/tog/wikis/3rd-party-plugins-acts_as_taggable_on_steroids)
* [acts\_as\_tree](https://github.com/tog/tog/wikis/3rd-party-plugins-acts_as_tree)
* [acts\_as\_state\_machine](https://github.com/tog/tog/wikis/3rd-party-plugins-acts_as_state_machine)

Follow each link above for a short installation guide incase you have to install them.			

Install
-------

* Install plugin form source:

<pre>
ruby script/plugin install git@github.com:tog/tog_vault.git
</pre>

* Generate installation migration:

<pre>
ruby script/generate migration install_conversatio
</pre>

	  with the following content:

<pre>
class InstallVault < ActiveRecord::Migration
  def self.up
    migrate_plugin "tog_vault", 3
  end

  def self.down
    migrate_plugin "tog_vault", 0
  end
end
</pre>

* Add conversatio's routes to your application's config/routes.rb

<pre>
map.routes_from_plugin 'tog_vault'
</pre> 

* And finally...

<pre> 
rake db:migrate
</pre> 

More
-------

"https://github.com/tog/tog_vault":https://github.com/tog/tog_vault

"https://github.com/tog/tog_vault/wikis":https://github.com/tog/tog_vault/wikis


Copyright (c) 2008 Keras Software Development, released under the MIT license