class SearchController < ApplicationController
  def search
    return unless params[:query]

    @projects = find(Project)
    @tasks = find(Task)
    @tags = find(Tag)
    @fields = %w(title)
  end

  def find(clazz)
    clazz.where("unaccent(lower(title)) LIKE ?", "%#{query}%")
  end

  def query
    @query ||= I18n.transliterate(params[:query].to_s.downcase)
  end
end
