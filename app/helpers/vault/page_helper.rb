module Vault::PageHelper
  include Vault::NodeHelper
  include Vault::BaseHelper

  def homepage
    @homepage ||= Page.find_by_parent_id(nil)
  end

  def show_page(url)
    begin
      page = Page.find_by_url(url)
      page.render if page
    rescue
      I18n.t("tog_vault.page.not_found", :url => url)
    end
  end
end
