class TasksController < CrudController
  before_action :project

  private

  def model
    @model ||= Task
  end

  def allowed_params
    allowed_params = params.require(:task).permit(:title, :description, :is_done, :attachment, tag_ids: [])
    allowed_params[:project_id] = project.id

    allowed_params
  end

  def index_fields
    @fields ||= %i(title is_done)
  end

  def set_fields
    @fields ||= %i(title description is_done attachment)
  end

  def project
    @project = Project.find(params[:project_id])
  end

  def redirect_url(object = nil)
    object ? try(:"project_#{@model.model_name.singular}_url", project, object) : try(:"project_#{@model.model_name.plural}_url", project)
  end
end
