class ReportType < ActiveRecord::Base
  belongs_to :category
  belongs_to :database

  has_many :fields, dependent: :destroy
  accepts_nested_attributes_for :fields, allow_destroy: true, reject_if: :all_blank

  validates :name, :category, :database, :sql, presence: true
  validates :sql, format: { without: /(?:^|\W)(?:ALTER|CREATE|DELETE|DROP|SET|TRUNCATE|UPDATE)(?:\W|$)/mi }
  validates :name, uniqueness: true
  validates_associated :fields
end
