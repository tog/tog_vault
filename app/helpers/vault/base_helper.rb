module Vault::BaseHelper

  #todo Allow title and co. customization
  def title
    config['vault.admin.title'] || I18n.t("tog_vault.vault_title")
  end
  def subtitle
    config['vault.admin.subtitle'] || I18n.t("tog_vault.vault_subtitle")
  end

  def image(name, options = {})
    image_tag(append_image_extension("/tog_vault/images/#{name}"), options)
  end

  def updated_stamp(model)
    unless model.new_record?
      updated_by = (model.updated_by || model.created_by)
      login = updated_by ? updated_by.login : nil
      time = (model.updated_at || model.created_at)
      if login or time
        html = "<p style='clear: left'><small>"
        html << I18n.t("tog_vault.last_updated")
        html << I18n.t("tog_vault.by_user", :user => login) if login
        html << I18n.t("tog_vault.at_time", :time => timestamp(time)) if time
        html << "</small></p>"
        html
      end
    else
      "<p class='clear'>&nbsp;</p>"
    end
  end

  def timestamp(time)
    format = "%I:%M <small>%p</small> on %B %d, %Y"
    time.strftime(format)
  end

  def save_model_button(model, options={})
    label = if model.new_record?
      I18n.t "tog_vault.create_model", :model => model.class.name
    else
      I18n.t "tog_vault.save_changes"
    end
    submit_tag label, options
  end

  def save_model_and_continue_editing_button(model, options={})
    submit_tag(I18n.t("tog_vault.save_and_continue", :name => 'continue'), options)
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
