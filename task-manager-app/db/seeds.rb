# Optional sample data. Run with: bundle exec rails db:seed
# It is safe to run more than once.

[
  { title: "Learn Docker", description: "Write a Dockerfile and build an image", status: "Pending" },
  { title: "Learn Kubernetes", description: "Deployments, Services and Minikube", status: "Pending" },
  { title: "Finish Task Manager app", description: "CRUD with Rails and PostgreSQL", status: "Completed" }
].each do |attributes|
  Task.find_or_create_by!(title: attributes[:title]) do |task|
    task.description = attributes[:description]
    task.status = attributes[:status]
  end
end

puts "Seeded #{Task.count} tasks."
