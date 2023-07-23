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

  def new_label
    I18n.t("common.new") + " " + model_name
  end

  def new_link
    raise 'Define me in specific controller_helper!'
  end

  def show_link(id)
    raise 'Define me in specific controller_helper!'
  end

  def back_to_link
    raise 'Define me in specific controller_helper!'
  end

  def edit_link
    raise 'Define me in specific controller_helper!'
  end

  def destroy_link
    raise 'Define me in specific controller_helper!'
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
