json.extract! product, :id, :title, :photo, :client_id, :ean, :short_description, :long_description, :short_description_generated_by_us, :long_description_generated_by_us, :date_generation_short_description, :date_generation_long_description, :site_id, :created_at, :updated_at
json.url product_url(product, format: :json)