class Field < ActiveRecord::Base
  belongs_to :field_type
  belongs_to :report_type

  validates :name, :field_type, :placeholder, presence: true
  validates :placeholder, format: { without: /\W/ }
  validates :placeholder, uniqueness: { scope: :report_type }
  validates :name, uniqueness: true
end
