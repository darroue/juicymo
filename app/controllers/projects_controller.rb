class ProjectsController < CrudController

  private

  def model
    @model ||= Project
  end

  def allowed_params
    params.require(:project).permit(:title, :position, :user_id)
  end
end
