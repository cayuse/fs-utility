json.array!(@diets) do |diet|
  json.extract! diet, :id, :student_id, :schoolyear_id
  json.url diet_url(diet, format: :json)
end
