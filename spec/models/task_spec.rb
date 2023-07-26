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
require 'rails_helper'

RSpec.describe Task, type: :model do
  before do
    @user = create(:user)
    @project = create(:project, user: @user)
  end

  describe '#create' do
    describe 'with valid attributes' do
      it 'creates task' do
        subject = Task.new(attributes_for(:task).merge(projects: [@project], user: @user))

        expect(subject.save!).to be(true)
      end

      it 'raises Task count' do
        subject = Task.new(attributes_for(:task).merge(projects: [@project], user: @user))

        expect { subject.save! }.to change(Task, :count).by(1)
      end
    end

    describe 'with invalid attributes' do
      it 'raises validation error' do
        subject = Task.new(attributes_for(:invalid_task).merge(projects: [@project], user: @user))
        expect { subject.save! }.to raise_error(ActiveRecord::RecordInvalid)
      end

      it "doesn't raise Task count" do
        subject = Task.new(attributes_for(:invalid_task).merge(projects: [@project], user: @user))

        expect { subject.save }.to change(Task, :count).by(0)
      end
    end
  end

  describe '#destroy' do
    it 'destroys task' do
      subject = Task.create(attributes_for(:task).merge(projects: [@project], user: @user))

      expect { subject.destroy }.to change { Task.count }.by(-1)
    end
  end

  describe '.for_user(user)' do
    it 'should return only user projects' do
      Task.create(attributes_for(:task).merge(projects: [@project], user: @user))
      3.times { Task.create(attributes_for(:task).merge(projects: [create(:project, user: create(:user))])) }

      expect(Task.for_user(@user).pluck(:user_id).uniq).to eq([@user.id])
    end
  end

  describe '.for_params(scope, params)' do
    it 'should return only tasks for project' do
      subject = create(:task, projects: [@project], user: @user)
      expect(Task.for_params(Task.for_user(@user), { project_ids: [@project.id.to_s] })).to eq([subject])
    end

    it 'should return only tasks for tags' do
      tags = []
      2.times { tags << create(:tag, user: @user) }
      subject2 = create(:task, projects: [@project], user: @user, tags: tags)
      expect(Task.for_params(Task.for_user(@user), { tag_ids: [tags.map(&:id).map(&:to_s)] })).to eq([subject2])
    end
  end
end
