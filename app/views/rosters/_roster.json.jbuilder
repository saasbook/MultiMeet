# frozen_string_literal: true

json.extract! roster, :id, :created_at, :updated_at
json.url roster_url(roster, format: :json)
