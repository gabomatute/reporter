json.array!(@report_types) do |report_type|
  json.extract! report_type, :id, :name, :category_id, :database_id, :description, :sql
  json.url admin_report_type_url(report_type, format: :json)
end
