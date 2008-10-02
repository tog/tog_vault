class Page < ActiveRecord::Base

  class MissingRootPageError < StandardError
    def initialize(message = I18n.t("tog_vault.page.db_missing_root_page")); super end
  end

  acts_as_taggable

  acts_as_tree :order => 'title ASC'
  belongs_to :created_by, :class_name => 'User'
  belongs_to :updated_by, :class_name => 'User'

  acts_as_state_machine :initial => :draft

  state :draft
  state :approved
  state :published

  event :published do
    transitions :from => [:draft, :approved] , :to => :published
  end

  event :approved do
    transitions :from => [:draft, :published] , :to => :approved
  end

  event :draft do
    transitions :from => [:published, :approved] , :to => :draft
  end

  validates_presence_of :title, :slug, :breadcrumb, :message => I18n.t("tog_vault.page.required")

  validates_length_of :title, :maximum => 255, :message => I18n.t("tog_vault.page.character_limit", :count => 255)
  validates_length_of :slug, :maximum => 100, :message => I18n.t("tog_vault.page.character_limit", :count => 100)
  validates_length_of :breadcrumb, :maximum => 160, :message => I18n.t("tog_vault.page.character_limit", :count => 160)

  validates_format_of :slug, :with => %r{^([-_.A-Za-z0-9]*|/)$}, :message => I18n.t("tog_vault.page.invalid_format")
  validates_uniqueness_of :slug, :scope => :parent_id, :message => I18n.t("tog_vault.page.slug_used")
  validates_numericality_of :id, :parent_id, :allow_nil => true, :only_integer => true, :message => I18n.t("tog_vault.page.must_be_number")

  #add_index :fields => %w[title content state] , :strip_html => 1

  def headers
    { 'Status' => ActionController::Base::DEFAULT_RENDER_STATUS_CODE }
  end

  def parent?
    !parent.nil?
  end

  def url
    if parent?
      parent.child_url(self)
    else
      clean_url(slug)
    end
  end

  def child_url(child)
    clean_url(url + '/' + child.slug)
  end

  def render
    content
  end

  def find_by_url(url, clean = true)
    url = clean_url(url) if clean
    my_url = self.url
    if (my_url == url)
      self
    elsif (url =~ /^#{Regexp.quote(my_url)}([^\/]*)/)
      slug_child = children.find_by_slug($1)
      if slug_child
        found = slug_child.find_by_url(url, clean)
        return found if found
      end
      children.each do |child|
        found = child.find_by_url(url, clean)
        return found if found
      end
      #todo Manage the NotFoundCase without a FileNotFoundPage class page
      raise "Need to manage not found cases"
    end
  end

  def process(request, response)
    @request, @response = request, response

    headers.each { |k,v| @response.headers[k] = v }
    @response.body = render
    @request, @response = nil, nil
  end

  class << self
    def find_by_url(url)
      root = find_by_parent_id(nil)
      raise MissingRootPageError unless root
      root.find_by_url(url)
    end
    # todo Allow customizations of the new pages
    def new_with_defaults
      page = new
    end
  end
  private

  def clean_url(url)
    "#{ url.strip }/".gsub(%r{//+}, '/').gsub(%r{^/},'')
  end

end
