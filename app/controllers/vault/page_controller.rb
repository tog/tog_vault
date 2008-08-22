class Vault::PageController < Admin::BaseController

  def index
    @homepage = Page.find_by_parent_id(nil)
  end

  def new
    @page = request.get? ? Page.new_with_defaults : Page.new
    @page.slug = params[:slug]
    @page.breadcrumb = params[:breadcrumb]
    @page.parent = Page.find_by_id(params[:parent_id])
    render :action => :edit if handle_new_or_edit_post
  end

  def edit
    @page = Page.find(params[:id])
    @old_page_url = @page.url
    handle_new_or_edit_post
  end

  def children
    @parent = Page.find(params[:id])
    @level = params[:level].to_i
    response.headers['Content-Type'] = 'text/html;charset=utf-8'
    render(:layout => false)
  end

  def remove
    @page = Page.find(params[:id])
    if request.post?
      announce_pages_removed(@page.children.count + 1)
      @page.destroy
      redirect_to cms_page_index_url
    end
  end


  protected

  def continue_url(options)
    options[:redirect_to] || (params[:continue] ? cms_page_edit_url(:id => @page.id) : cms_page_index_url)
  end


  private

  def handle_new_or_edit_post(options = {})
    options.symbolize_keys
    if request.post?
      @page.attributes = params[:page]
      begin
        if @page.save!
          @page.send("#{params[:state].to_s}!")
          announce_saved(options[:saved_message])
          redirect_to continue_url(options)
          return false
        else
          announce_validation_errors
        end
      rescue ActiveRecord::StaleObjectError
        #todo Manage Lock Versions
        announce_update_conflict
      end
    end
    true
  end

  def announce_saved(message = nil)
    flash[:notice] = message || "Your page has been saved below."
  end

  def announce_validation_errors
    flash[:error] = "Validation errors occurred while processing this form. Please take a moment to review the form and correct any input errors before continuing."
  end

  def announce_update_conflict
    flash[:error] = "#{humanized_model_name} has been modified since it was last loaded. Changes cannot be saved without potentially losing data."
  end

  def announce_pages_removed(count)
    flash[:notice] = if count > 1
      "The pages were successfully removed from the site."
    else
      "The page was successfully removed from the site."
    end
  end

end
