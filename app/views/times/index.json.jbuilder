# frozen_string_literal: true

json.array! @times, partial: 'times/time', as: :time
