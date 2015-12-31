# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

FieldType.create([
  { name: "String",  data_type: "string", valid_regex: /^(?:\w|\s)+$/ },
  { name: "Integer", data_type: "int",    valid_regex: /^\d+$/ },
  { name: "Float",   data_type: "float",  valid_regex: /^\d+(?:\.\d+|)$/ },
  { name: "Boolean", data_type: "bool",   valid_regex: /^(?:true|false)$/i },
  { name: "Date",    data_type: "date",   valid_regex: /^(?:\d{1,2}-){2}(?:\d{2}|\d{4})$/ }
])

Category.create(
  { name: "Default" }
)

Database.create(
  { name: "Reporter", database: "reporter_#{Rails.env}", adapter: "postgresql" }
)
