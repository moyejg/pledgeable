json.extract! event, :id, :name, :description, :amount, :event_completed_on, :user_id, :created_at, :updated_at
json.url event_url(event, format: :json)
