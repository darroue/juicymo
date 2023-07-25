# frozen_string_literal: true
require 'pagy/extras/bootstrap'

module ApplicationHelper
  include Pagy::Frontend

  def new_label
    I18n.t("common.new") + " " + model_name
  end

  def show_label
    I18n.t("common.show") + " " + model_name_zero
  end

  def edit_label
    I18n.t("common.edit") + " " + model_name
  end

  def back_to_label
    I18n.t("common.back_to") + " " + model_name_plural
  end

  def destroy_label
    I18n.t("common.destroy") + " " + model_name
  end

  def new_label(model = nil)
    I18n.t("common.new") + " " + model_name({}, model)
  end

  def new_link(model = nil)
    model ||= @model
    link_to new_label(model), try(:"new_#{model.model_name.singular}_path"), class: "btn btn-success"
  end

  def back_to_link
    link_to back_to_label, try(:"#{@model.model_name.plural}_path"), class: "btn btn-secondary"
  end

  def show_link(id)
    link_to show_label, try(:"#{@model.model_name.singular}_path", id: id), class: "btn btn-info"
  end

  def edit_link(id)
    link_to edit_label, try(:"edit_#{@model.model_name.singular}_path", id: id), class: "btn btn-primary"
  end

  def destroy_link(id)
    link_to destroy_label, try(:"#{@model.model_name.singular}_path", id: id), class: "btn btn-danger", data: { turbo_method: :delete, turbo_confirm: I18n.t("common.confirm") }
  end

  def model_name(options = {}, model = nil)
    model ||= @model
    model.model_name.human(options)
  end

  def model_name_plural
    model_name(count: 3)
  end

  def model_name_zero
    model_name(count: 0)
  end

  def field_label(field)
    @model.human_attribute_name(field)
  end

  def create_notice
    model_name + ' ' + I18n.t("common.created")
  end

  def update_notice
    model_name + ' ' + I18n.t("common.updated")
  end

  def destroy_notice
    model_name + ' ' + I18n.t("common.destroyed")
  end
end
