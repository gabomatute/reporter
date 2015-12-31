json.array!(@databases) do |database|
  json.extract! database, :id, :name, :adapter, :host, :port, :username
  json.url admin_database_url(database, format: :json)
end
