json.array!(@schoolyears) do |schoolyear|
  json.extract! schoolyear, :id, :name
  json.url schoolyear_url(schoolyear, format: :json)
end
