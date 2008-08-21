module Vault::BaseHelper

  #todo Allow title and co. customization
  def title
    config['vault.admin.title'] || "Vault CMS"[:vault_title]
  end
  def subtitle
    config['vault.admin.subtitle'] || "Your content on a shiny vault."[:vault_subtitle]
  end

  def image(name, options = {})
    image_tag(append_image_extension("vault/#{name}"), options)
  end

  def updated_stamp(model)
    unless model.new_record?
      updated_by = (model.updated_by || model.created_by)
      login = updated_by ? updated_by.login : nil
      time = (model.updated_at || model.created_at)
      if login or time
        html = "<p style='clear: left'><small>"
        html << "Last updated "[:last_updated]
        html << "by #{login} "[:by_user, {:login => login}] if login
        html << "at #{time} "[:at_time, {:time => timestamp(time)}] if time
        html << "</small></p>"
        html
      end
    else
      "<p class='clear'>&nbsp;</p>"
    end
  end

  def timestamp(time)
    format = "%I:%M <small>%p</small> on %B %d, %Y"[:timestamp_format]
    time.strftime(format)
  end

  def save_model_button(model)
    label = if model.new_record?
      "Create #{model.class.name}"[:create_model, {:model => model.class.name }]
    else
      "Save Changes"[:save_changes]
    end
    submit_tag label
  end

  def save_model_and_continue_editing_button(model)
    submit_tag "Save and Continue Editing"[:save_and_continue], :name => 'continue'
  end

  private
    def append_image_extension(name)
      unless name =~ /\.(.*?)$/
        name + '.png'
      else
        name
      end
    end
end
