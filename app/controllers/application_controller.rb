# frozen_string_literal: true

class ApplicationController < ActionController::Base
  include Pagy::Backend

  before_action :authenticate_user!
  before_action :index_fields, only: :index
  before_action :set_fields, except: :index
end
