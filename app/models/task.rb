# frozen_string_literal: true

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
#  user_id     :bigint           not null
#
# Indexes
#
#  index_tasks_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
class Task < ApplicationRecord
  has_many :task_tags, dependent: :destroy
  has_many :tags, through: :task_tags

  belongs_to :user
  has_and_belongs_to_many :projects, dependent: :nulify
  has_one_attached :attachment

  validates :title, presence: true

  scope :for_user, lambda { |current_user|
    where(user: current_user).order(:created_at)
  }

  scope :for_params, lambda { |scope, params|
    if (project_ids = params[:project_ids].try(:reject, &:empty?)).present?
      scope = scope.joins(:projects).where(projects: { id: project_ids })
    end

    if (tag_ids = params[:tag_ids].try(:reject, &:empty?)).present?
      scope = scope.joins(:tags).where(tags: { id: tag_ids })
    end

    unless (is_done = params[:is_done]).nil?
      scope = scope.where(is_done:)
    end

    scope.distinct(:id)
  }
end
