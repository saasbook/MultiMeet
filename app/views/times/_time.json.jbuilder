# frozen_string_literal: true

json.extract! time, :id, :created_at, :updated_at
json.url time_url(time, format: :json)
