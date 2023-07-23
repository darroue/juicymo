class TasksController < CrudController
  private

  def model
    @model ||= Task
  end

  def allowed_params
    allowed_params = params.require(:task).permit(:project, :title, :description, :is_done, :attachment, tag_ids: [])
    allowed_params[:project_id] = project.id

    allowed_params
  end

  def index_fields
    @fields ||= %i(project title is_done)
  end

  def set_fields
    @fields ||= %i(project title description is_done attachment)
  end
end
