require "test_helper"

class TaskTest < ActiveSupport::TestCase
  test "is valid with a title" do
    assert Task.new(title: "Write report").valid?
  end

  test "status defaults to Pending" do
    assert_equal "Pending", Task.new(title: "Write report").status
  end

  test "requires a title" do
    task = Task.new(title: "   ")

    assert_not task.valid?
    assert_includes task.errors[:title], "can't be blank"
  end

  test "title cannot be longer than 255 characters" do
    assert_not Task.new(title: "a" * 256).valid?
  end

  test "rejects an unknown status" do
    task = Task.new(title: "Write report", status: "Done")

    assert_not task.valid?
    assert_includes task.errors[:status], "must be Pending or Completed"
  end

  test "toggle_status! switches between Pending and Completed" do
    task = Task.create!(title: "Write report")

    task.toggle_status!
    assert_equal "Completed", task.reload.status

    task.toggle_status!
    assert_equal "Pending", task.reload.status
  end
end
