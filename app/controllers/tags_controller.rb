# frozen_string_literal: true

class TagsController < CrudController
  private

  def model
    @model ||= Tag
  end

  def allowed_params
    allowed_params = params.require(:tag).permit(:title, task_ids: [])
    allowed_params[:user_id] = current_user.id

    allowed_params
  end

  def fields
    @fields ||= action_name == 'index' ? %i[title] : %i[title tasks]
  end
end
