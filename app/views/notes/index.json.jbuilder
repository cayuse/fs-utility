json.array!(@notes) do |note|
  json.extract! note, :id, :student, :references, :entry, :text
  json.url note_url(note, format: :json)
end
