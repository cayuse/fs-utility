json.array!(@dietdocuments) do |dietdocument|
  json.extract! dietdocument, :id, :diet_id
  json.url dietdocument_url(dietdocument, format: :json)
end
