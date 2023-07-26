# frozen_string_literal: true

module TasksHelper
  def toggle_link(object)
    if object.is_done
      link_to I18n.t('actions.toggle.undone'), task_toggle_path(object), class: 'btn btn-warning',
                                                                         data: { turbo_method: :post }
    else
      link_to I18n.t('actions.toggle.done'), task_toggle_path(object), class: 'btn btn-success',
                                                                       data: { turbo_method: :post }
    end
  end

  def link_params
    {
      task: {
        project_ids: params.dig(:task, :project_ids) || [],
        tag_ids: params.dig(:task, :tag_ids) || []
      }
    }
  end
end
