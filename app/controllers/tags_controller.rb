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

  def index_fields
    @fields ||= %i(title)
  end

  def set_fields
    @fields ||= %i(title tasks)
  end
end
