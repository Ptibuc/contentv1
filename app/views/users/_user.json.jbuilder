json.extract! user, :id, :photo, :langage, :is_admin, :created_at, :updated_at
json.url user_url(user, format: :json)