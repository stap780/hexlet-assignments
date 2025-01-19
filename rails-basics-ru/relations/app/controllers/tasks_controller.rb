# frozen_string_literal: true

class TasksController < ApplicationController
  before_action :set_task, only: %i[show edit update destroy]

  def index
    @tasks = Task.all
  end

  def new
    @task = Task.new
  end

  def show; end

  def edit; end

  def create
    @task = Task.new(task_params)

    if @task.save
      flash[:success] = 'Task was successfully created.'
      redirect_to @task
    else
      flash[:error] = 'Task was not created.'
      render :new
    end
  end

  def update
    if @task.update(task_params)
      flash[:success] = 'Task was successfully updated.'
      redirect_to @task
    else
      flash[:error] = 'Task update failed'
      render :edit
    end
  end

  def destroy
    if @task.destroy
      flash[:success] = 'Task deleted'
      redirect_to tasks_path
    else
      flash[:error] = 'Task could not be deleted'
    end
  end

  private

  def task_params
    params.require(:task).permit(:name, :description, :user_id, :status_id)
  end

  def set_task
    @task = Task.find(params[:id])
  end
end
