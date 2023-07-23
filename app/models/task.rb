# == Schema Information
#
# Table name: tasks
#
#  id          :bigint           not null, primary key
#  description :text
#  is_done     :boolean          default(FALSE), not null
#  title       :string           not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  project_id  :bigint           not null
#
# Indexes
#
#  index_tasks_on_project_id  (project_id)
#
# Foreign Keys
#
#  fk_rails_...  (project_id => projects.id)
#
class Task < ApplicationRecord
  belongs_to :project
  has_one_attached :attachment
  has_many :task_tags, dependent: :destroy
  has_many :tags, through: :task_tags

  validates :title, presence: true

  scope :for_user, -> (current_user) {
    joins(:project).where(
      projects: {
        user: current_user
      }
    ).order(:id)
  }

  scope :for_project, -> (project) {
    return unless project

    where(project_id: project.id)
  }
end
