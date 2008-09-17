class Vault::SiteController < ApplicationController

  def show_page
    url = params[:url]
    url = Array === url ? url.join('/') : url.to_s
    show_uncached_page(url)
  end

  def not_found
  end

  def error
  end

  private

  # todo Manage diferent states of the page.
  def find_page(url)
    found = Page.find_by_url(url)
    found if found #and (found.published?)
  end

  def process_page(page)
    page.process(request, response)
  end

  def show_uncached_page(url)
    @page = find_page(url)
    unless @page.nil?
      #process_page(@page)
      #@performed_render = true
      render :text => @page.content #, :layout => "community"
    else
      render :template => 'site/not_found', :status => 404
    end
  rescue Page::MissingRootPageError
    redirect_to cms_page_index_url
  end

end
