json.array!(@wishes) do |wish|
  json.extract! wish, :id, :team_id, :title, :description, :impact_on_business, :time_required, :ease_of_development, :deadline
  json.url wish_url(wish, format: :json)
end
