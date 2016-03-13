json.array!(@departments) do |department|
  json.extract! department, :id, :company_id, :name, :description, :credit
  json.url department_url(department, format: :json)
end
