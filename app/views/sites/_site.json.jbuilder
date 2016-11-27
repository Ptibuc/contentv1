json.extract! site, :id, :url, :system, :logo, :lang, :user_id, :created_at, :updated_at
json.url site_url(site, format: :json)