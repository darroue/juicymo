module TagsHelper
  def new_link
    link_to new_label, try(:"new_#{@model.model_name.singular}_path"), class: "btn btn-success"
  end

  def back_to_link
    link_to back_to_label, try(:"#{@model.model_name.plural}_path"), class: "btn btn-secondary"
  end

  def show_link(id)
    link_to show_label, try(:"#{@model.model_name.singular}_path", id: id), class: "btn btn-info"
  end

  def edit_link(id)
    link_to edit_label, try(:"edit_#{@model.model_name.singular}_path", id: id), class: "btn btn-primary"
  end

  def destroy_link(id)
    link_to destroy_label, try(:"project_#{@model.model_name.singular}_path", id: id), class: "btn btn-danger", data: { turbo_method: :delete, turbo_confirm: I18n.t("common.confirm") }
  end
end
