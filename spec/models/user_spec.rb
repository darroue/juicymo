# frozen_string_literal: true

# == Schema Information
#
# Table name: users
#
#  id                     :bigint           not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  last_name              :string           not null
#  name                   :string           not null
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
# Indexes
#
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#
require 'rails_helper'

RSpec.describe User, type: :model do
  describe '#create' do
    describe 'with valid attributes' do
      it 'creates user' do
        subject = User.new(attributes_for(:user))

        expect(subject.save!).to be(true)
      end

      it 'raises User count' do
        subject = User.new(attributes_for(:user))

        expect { subject.save! }.to change(User, :count).by(1)
      end
    end

    describe 'with invalid attributes' do
      it 'raises validation error' do
        subject = User.new(attributes_for(:invalid_user))
        expect { subject.save! }.to raise_error(ActiveRecord::RecordInvalid)
      end

      it "doesn't raise User count" do
        subject = User.new(attributes_for(:invalid_user))

        expect { subject.save }.to change(User, :count).by(0)
      end
    end
  end

  describe '#destroy' do
    it 'destroys user and related objects' do
      subject = User.create(attributes_for(:user))
      subject.projects << create(:project)
      subject.tags << create(:tag)
      subject.projects.first.tasks << create(:task)

      expect {subject.destroy}.to change {User.count}.by(-1).and change {Project.count}.by(-1).and change {Tag.count}.by(-1).and change {Task.count}.by(-1)
    end
  end
end
