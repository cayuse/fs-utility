json.array!(@site_settings) do |site_setting|
  json.extract! site_setting, :id, :year_id
  json.url site_setting_url(site_setting, format: :json)
end
