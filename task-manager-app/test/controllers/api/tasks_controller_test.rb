require "test_helper"

class Api::TasksControllerTest < ActionDispatch::IntegrationTest
  test "full create, read, update and delete cycle" do
    post "/api/tasks", params: { title: "Learn Rails", description: "CRUD app" }, as: :json
    assert_response :created
    id = response.parsed_body["id"]
    assert_equal "Pending", response.parsed_body["status"]

    get "/api/tasks/#{id}"
    assert_response :ok
    assert_equal "Learn Rails", response.parsed_body["title"]

    put "/api/tasks/#{id}", params: { status: "Completed" }, as: :json
    assert_response :ok
    assert_equal "Completed", response.parsed_body["status"]

    get "/api/tasks"
    assert_response :ok
    assert_includes response.parsed_body.map { |task| task["id"] }, id

    delete "/api/tasks/#{id}"
    assert_response :ok

    get "/api/tasks/#{id}"
    assert_response :not_found
  end

  test "create without a title returns 422" do
    post "/api/tasks", params: { title: "" }, as: :json

    assert_response :unprocessable_entity
    assert_includes response.parsed_body["errors"], "Title can't be blank"
  end

  test "create with an invalid status returns 422" do
    post "/api/tasks", params: { title: "Test", status: "Done" }, as: :json

    assert_response :unprocessable_entity
  end

  test "non-numeric id returns 400" do
    get "/api/tasks/abc"

    assert_response :bad_request
  end

  test "unknown id returns 404" do
    get "/api/tasks/999999999"

    assert_response :not_found
  end

  test "unknown api route returns a JSON 404" do
    get "/api/unknown"

    assert_response :not_found
    assert_equal "Endpoint not found", response.parsed_body["error"]
  end
end
