module Vault::NodeHelper

  def render_node(page, locals = {})
    @current_node = page
    locals.reverse_merge!(:level => 0, :simple => false).merge!(:page => page)
    render :partial => 'node', :locals =>  locals
  end

  def padding_left(level)
    (level * 22) + 40
  end

  def show_all?
    @controller.action_name == 'remove'
  end

  def expanded_rows
    unless @expanded_rows
      @expanded_rows = case
      when row_string = (cookies['expanded_rows'] || []).first
        row_string.split(',').map { |x| Integer(x) rescue nil }.compact
      else
        []
      end
      (@expanded_rows << homepage.id).uniq if homepage
    end
    @expanded_rows
  end

  def expanded
    show_all? || expanded_rows.include?(@current_node.id)
  end

  def expander
    unless @current_node.children.empty?
      image((expanded ? "collapse" : "expand"),
            :class => "expander", :alt => 'toggle children',
            :title => '')
    else
      ""
    end
  end

  def icon
    image('page', :class => "icon", :alt => 'page-icon', :title => '')
  end

  def node_title
    %{<span class="title">#{ @current_node.title }</span>}
  end

  def spinner
    image('spinner.gif',
            :class => 'busy', :id => "busy-#{@current_node.id}",
            :alt => "",  :title => "",
            :style => 'display: none;')
  end

  def children_class
    unless @current_node.children.empty?
      if expanded
        " children-visible"
      else
        " children-hidden"
      end
    else
      " no-children"
    end
  end

end
