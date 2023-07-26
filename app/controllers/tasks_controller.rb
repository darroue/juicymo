# frozen_string_literal: true

class TasksController < CrudController
  def index
    @object = model.new
    @pagy, @collection = pagy(model.for_params(model.for_user(current_user), params_for_filter))
  end

  def done
    params_for_filter[:is_done] = @is_done = true

    index

    render :index
  end

  def undone
    params_for_filter[:is_done] = @is_done = false

    index

    render :index
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
    params.require(:task).permit(:title, :description, :is_done, :attachment, tag_ids: [], project_ids: [])
  end

  def params_for_filter
    @params_for_filter ||= (params['task'] ? params.require(:task).permit(:is_done, project_ids: [], tag_ids: []) : {})
  end

  def fields
    @fields ||= if %w[index done
                      undone].include?(action_name)
                  %i[title
                     is_done]
                else
                  %i[projects title description is_done attachment]
                end
  end
end
