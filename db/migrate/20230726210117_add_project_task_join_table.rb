class AddProjectTaskJoinTable < ActiveRecord::Migration[7.0]
  def change
    create_table :projects_tasks do |t|
      t.references :project, foreign_key: true
      t.references :task, foreign_key: true
    end
  end
end
