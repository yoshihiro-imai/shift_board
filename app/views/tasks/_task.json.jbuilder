json.extract! task, :id, :date, :intime, :outtime, :project_id, :created_at, :updated_at
json.url task_url(task, format: :json)
