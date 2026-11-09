class TasksController < ApplicationController
  before_action :set_task, only: %i[show edit update destroy toggle]

  # GET /  and  GET /tasks  (optional ?status=Pending or ?status=Completed)
  def index
    @task = Task.new
    load_tasks
  end

  # GET /tasks/:id
  def show
  end

  # GET /tasks/new
  def new
    @task = Task.new
  end

  # POST /tasks
  def create
    @task = Task.new(task_params)

    if @task.save
      redirect_to tasks_path, notice: "Task created."
    else
      load_tasks
      render :index, status: :unprocessable_entity
    end
  end

  # GET /tasks/:id/edit
  def edit
  end

  # PATCH/PUT /tasks/:id
  def update
    if @task.update(task_params)
      redirect_to tasks_path, notice: "Task updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # PATCH /tasks/:id/toggle  (Pending <-> Completed)
  def toggle
    @task.toggle_status!
    redirect_back fallback_location: tasks_path, notice: "Task marked as #{@task.status}."
  end

  # DELETE /tasks/:id
  def destroy
    @task.destroy!
    redirect_to tasks_path, notice: "Task deleted."
  end

  private

  def set_task
    @task = Task.find(params[:id])
  end

  def task_params
    params.require(:task).permit(:title, :description, :status)
  end

  # Loads the task list (with the active filter) and the counters.
  def load_tasks
    @status = params[:status] if Task::STATUSES.include?(params[:status])

    @tasks = Task.newest_first
    @tasks = @tasks.with_status(@status) if @status

    counts = Task.group(:status).count
    @counts = {
      pending: counts.fetch("Pending", 0),
      completed: counts.fetch("Completed", 0)
    }
    @counts[:total] = @counts[:pending] + @counts[:completed]
  end
end
