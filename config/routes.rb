with_options(:controller => 'vault/page') do |page|
  page.cms_index             'admin/cms',                              :action => 'index'       
  page.cms_page_index        'admin/cms/pages',                        :action => 'index'       
  page.cms_page_edit         'admin/cms/pages/edit/:id',               :action => 'edit'
  page.cms_page_new          'admin/cms/pages/:parent_id/child/new',   :action => 'new'                                            
  page.cms_page_remove       'admin/cms/pages/remove/:id',             :action => 'remove'
  page.cms_homepage_new      'admin/cms/pages/new/homepage',           :action => 'new',        :slug => '/', :breadcrumb => 'Home'
  page.cms_page_children     'admin/cms/ui/pages/children/:id/:level', :action => 'children',   :level => '1'
end

with_options(:controller => 'vault/user') do |user|
  user.cms_user_index        'admin/cms/users',                        :action => 'index'
end

prefix = Tog::Plugins.settings(:tog_vault, :public_prefix) || "cms"
with_options(:controller => 'vault/site') do |site|
  site.cms_homepage     prefix,                :action => 'show_page', :url => '/'
  site.cms_not_found    prefix + '/error/404', :action => 'not_found'
  site.cms_error        prefix + '/error/500', :action => 'error'
  site.cms_connect      prefix + '/*url',      :action => 'show_page'
end

with_options(:controller => 'vault/mail') do |mail|
  mail.contact_new        'mailer/new',     :action => 'new'
  mail.contact_create     'mailer/create',  :action => 'create'
end
