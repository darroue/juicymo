# frozen_string_literal: true

class SearchController < ApplicationController
  def search
    return unless params[:query].present?

    @projects = find(Project)
    @tasks = find(Task)
    @tags = find(Tag)
    @fields = %w[title]
  end

  def find(clazz)
    clazz.for_user(current_user).where("unaccent(lower(#{clazz.table_name}.title)) LIKE ?", "%#{query}%")
  end

  def query
    @query ||= I18n.transliterate(params[:query].to_s.downcase)
  end
end
