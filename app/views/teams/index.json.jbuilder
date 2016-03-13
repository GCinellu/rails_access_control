json.array!(@teams) do |team|
  json.extract! team, :id, :name, :description, :available_credit
  json.url team_url(team, format: :json)
end
