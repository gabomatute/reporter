class FieldType < ActiveRecord::Base
  has_many :fields

  validates :name, :data_type, :valid_regex, presence: true
  validates :name, uniqueness: true

  def valid_regex 
    Regexp.new super
  end

  def valid_regex=(value)
    super value.to_s
  end
end
