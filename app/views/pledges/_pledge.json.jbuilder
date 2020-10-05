json.extract! pledge, :id, :amount, :max_amount, :user_id, :event_id, :created_at, :updated_at
json.url pledge_url(pledge, format: :json)
