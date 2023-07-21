# frozen_string_literal: true

module ApplicationHelper
  include Pagy::Frontend

  def back_to_link
    link_to back_to_label, try(:"#{@model.model_name.plural}_path"), class: "btn btn-secondary"
  end

  def edit_link
    link_to edit_label, try(:"edit_#{@model.model_name.singular}_path"), class: "btn btn-primary"
  end

  def edit_label
    I18n.t("common.edit") + " " + model_name
  end

  def back_to_label
    I18n.t("common.back_to") + " " + model_name_plural
  end

  def destroy_to_label
    I18n.t("common.destroy") + " " + model_name
  end

  def new_label
    I18n.t("common.new") + " " + model_name
  end

  def new_link
    link_to new_label, try(:"new_#{@model.model_name.singular}_path"), class: "btn btn-success"
  end

  def show_link(id)
    link_to show_label, try(:"#{@model.model_name.singular}_path", id: id), class: "btn btn-info"
  end

  def show_label
    I18n.t("common.show") + " " + model_name_zero
  end

  def destroy_button
    button_to destroy_to_label, @object, class: "btn btn-danger", data: { turbo_method: :delete, turbo_confirm: I18n.t("common.confirm") }
  end

  def model_name(options = {})
    @model.model_name.human(options)
  end

  def model_name_plural
    model_name(count: 3)
  end

  def model_name_zero
    model_name(count: 0)
  end

  def new_label
    I18n.t("common.new") + " " + model_name
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
