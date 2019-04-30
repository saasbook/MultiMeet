# frozen_string_literal: true

json.array! @rankings, partial: 'rankings/ranking', as: :ranking
