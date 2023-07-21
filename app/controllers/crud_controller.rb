class CrudController < ApplicationController
  before_action :set_object, only: %i[ show edit update destroy ]

  include ApplicationHelper

  def index
    Pagy::DEFAULT[:items] = 2
    @pagy, @collection = pagy(model.for_user(current_user))
  end

  def show
  end

  def new
    @object = model.new
  end

  def edit
  end

  def create
    @object = model.new(allowed_params)

    respond_to do |format|
      if @object.save
        format.html { redirect_to project_url(@object), notice: create_notice }
        format.json { render :show, status: :created, location: @object }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @object.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @object.update(allowed_params)
        format.html { redirect_to project_url(@object), notice: update_notice }
        format.json { render :show, status: :ok, location: @object }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @object.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @object.destroy

    respond_to do |format|
      format.html { redirect_to projects_url, notice: destroy_notice }
      format.json { head :no_content }
    end
  end

  private
    def set_object
      @object = model.find(params[:id])
    end
end
