class RemoveProjectIdColumnFromTasks < ActiveRecord::Migration[7.0]
  def change
    remove_column :tasks, :project_id
  end
end
