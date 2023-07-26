# frozen_string_literal: true

class ProjectsController < CrudController
  private

  def model
    @model ||= Project
  end

  def allowed_params
    allowed_params = params.require(:project).permit(:title, :position, task_ids: [])
    allowed_params[:user_id] = current_user.id

    allowed_params
  end

  def fields
    @fields ||= if action_name == "index"
                  %i[title position]
                else
                  %i[title position tasks]
                end
  end
end
