class Category < ActiveRecord::Base
  has_many :report_types, dependent: :restrict_with_error

  validates :name, uniqueness: true, presence: true
end
