class TasksController < CrudController
  def index
    @object = model.new
    @pagy, @collection = pagy(model.for_params(model.for_user(current_user), filter_params))
  end

  def toggle
    @object = model.for_user(current_user).find(params[:task_id])

    @object.update is_done: !@object.is_done

    redirect_back fallback_location: tasks_path
  end

  private

  def model
    @model ||= Task
  end

  def allowed_params
    params.require(:task).permit(:project_id, :title, :description, :is_done, :attachment, tag_ids: [])
  end

  def filter_params
    return {} unless params['task']

    params.require(:task).permit(project_ids: [], tag_ids: [])
  end

  def index_fields
    @fields ||= %i(project title is_done)
  end

  def set_fields
    @fields ||= %i(project title description is_done attachment)
  end
end
