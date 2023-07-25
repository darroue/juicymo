# frozen_string_literal: true

module SearchHelper
  def title(value)
    query = params[:query]

    return unless value && query

    value.downcase.gsub(
      query,
      content_tag(:span, query, class: 'text-warning').to_s
    ).html_safe
  end
end
