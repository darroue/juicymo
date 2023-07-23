module TasksHelper
  def new_link
    link_to new_label, try(:"new_project_#{@model.model_name.singular}_path", project_id: @project.id), class: "btn btn-success"
  end

  def back_to_link
    link_to back_to_label, try(:"project_#{@model.model_name.plural}_path", project_id: @project.id), class: "btn btn-secondary"
  end

  def show_link(id)
    link_to show_label, try(:"project_#{@model.model_name.singular}_path", project_id: @project.id, id: id), class: "btn btn-info"
  end

  def edit_link(id)
    link_to edit_label, try(:"edit_project_#{@model.model_name.singular}_path", project_id: @project.id, id: id), class: "btn btn-primary"
  end

  def destroy_link(id)
    link_to destroy_label, try(:"project_#{@model.model_name.singular}_path", project_id: @project.id, id: id), class: "btn btn-danger", data: { turbo_method: :delete, turbo_confirm: I18n.t("common.confirm") }
  end
end
