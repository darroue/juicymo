class ProjectsController < CrudController

  private

  def model
    @model ||= Project
  end

  def allowed_params
    params.require(:project).permit(:title, :position, :user_id)
  end

  def index_fields
    @fields ||= %i(title position)
  end

  def set_fields
    @fields ||= %i(title position)
  end
end
