class ProjectsController < CrudController

  private

  def model
    @model ||= Project
  end

  def allowed_params
    allowed_params = params.require(:project).permit(:title, :position)
    allowed_params[user_id] = current_user.id

    allowed_params
  end

  def index_fields
    @fields ||= %i(title position)
  end

  def set_fields
    @fields ||= %i(title position)
  end
end
