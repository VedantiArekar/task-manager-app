require "test_helper"

class TasksControllerTest < ActionDispatch::IntegrationTest
  test "dashboard loads" do
    get root_path

    assert_response :success
    assert_select "h1", "Task Manager"
  end

  test "creates a task" do
    assert_difference("Task.count", 1) do
      post tasks_path, params: { task: { title: "Buy milk", description: "", status: "Pending" } }
    end

    assert_redirected_to tasks_path
  end

  test "shows validation errors when the title is empty" do
    assert_no_difference("Task.count") do
      post tasks_path, params: { task: { title: "", description: "", status: "Pending" } }
    end

    assert_response :unprocessable_entity
  end

  test "updates a task" do
    task = Task.create!(title: "Old title")

    patch task_path(task), params: { task: { title: "New title" } }

    assert_redirected_to tasks_path
    assert_equal "New title", task.reload.title
  end

  test "toggles the status" do
    task = Task.create!(title: "Toggle me")

    patch toggle_task_path(task)

    assert_equal "Completed", task.reload.status
  end

  test "deletes a task" do
    task = Task.create!(title: "Delete me")

    assert_difference("Task.count", -1) do
      delete task_path(task)
    end

    assert_redirected_to tasks_path
  end

  test "a missing task redirects to the dashboard" do
    get task_path(999_999_999)

    assert_redirected_to tasks_path
  end

  test "health check reports the database as connected" do
    get "/health"

    assert_response :success
    assert_equal "ok", response.parsed_body["status"]
  end
end
