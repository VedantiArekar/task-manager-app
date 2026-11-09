# Task Manager (Ruby on Rails + PostgreSQL)

A simple CRUD web application. Create, view, edit, delete tasks and switch them between **Pending** and **Completed**.

- **Backend:** Ruby on Rails 8 (Ruby 3.2 or newer)
- **Database:** PostgreSQL through Active Record (`pg` gem)
- **Frontend:** Rails views (ERB), plain CSS and a little JavaScript
- **Port:** 3000

## Pages and API

| Method    | URL              | Purpose                          |
| --------- | ---------------- | -------------------------------- |
| GET       | `/`              | Dashboard (web page)             |
| GET       | `/api/tasks`     | List all tasks (JSON)            |
| GET       | `/api/tasks/:id` | Get one task (JSON)              |
| POST      | `/api/tasks`     | Create a task (JSON)             |
| PUT/PATCH | `/api/tasks/:id` | Update a task (JSON)             |
| DELETE    | `/api/tasks/:id` | Delete a task (JSON)             |
| GET       | `/health`        | Health check, includes database  |

## Configuration

All configuration comes from environment variables. Copy `.env.example` to `.env`:

```powershell
Copy-Item .env.example .env
```

The most important variable is `DATABASE_URL`:

```
postgresql://USER:PASSWORD@HOST:5432/DATABASE
```

## Quick start

```powershell
bundle install
bundle exec rails db:create
bundle exec rails db:migrate
bundle exec rails server -b 0.0.0.0 -p 3000
```

Open http://localhost:3000

See the full instructions in the chat answer that came with this project.
