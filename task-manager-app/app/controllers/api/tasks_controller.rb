module Api
  class TasksController < BaseController
    before_action :validate_id, only: %i[show update destroy]
    before_action :set_task, only: %i[show update destroy]

    # GET /api/tasks  (optional ?status=Pending or ?status=Completed)
    def index
      tasks = Task.newest_first
      tasks = tasks.with_status(params[:status]) if Task::STATUSES.include?(params[:status])

      render json: tasks
    end

    # GET /api/tasks/:id
    def show
      render json: @task
    end

    # POST /api/tasks
    def create
      task = Task.new(task_params)

      if task.save
        render json: task, status: :created
      else
        render_validation_errors(task)
      end
    end

    # PUT/PATCH /api/tasks/:id  (send only the fields you want to change)
    def update
      if @task.update(task_params)
        render json: @task
      else
        render_validation_errors(@task)
      end
    end

    # DELETE /api/tasks/:id
    def destroy
      @task.destroy!
      render json: { message: "Task deleted", id: @task.id }
    end

    private

    # Accepts JSON like {"title": "...", "description": "...", "status": "Pending"}
    def task_params
      params.permit(:title, :description, :status)
    end

    def validate_id
      return if params[:id].to_s.match?(/\A\d+\z/)

      render json: { error: "Invalid task id" }, status: :bad_request
    end

    def set_task
      @task = Task.find(params[:id])
    end

    def render_validation_errors(task)
      render json: { errors: task.errors.full_messages }, status: :unprocessable_entity
    end
  end
end
