class FieldInput
  # Tableless Model
  include Tableless

  belongs_to :report
  belongs_to :field

  column :input

  validates :field, presence: true
  validates :input, presence: true, if: "field.required"
  validate :input_validity

  # Declares attributes for ActiveModel::Serialization method serializable_hash
  def attributes
    {'field_id' => nil, 'input' => nil}
  end

  # Returns a Hash with the replacement for the placeholder
  def replacement
    { "??#{field.placeholder}??" => input }
  end

  private
    def input_validity
      unless input.match(field.field_type.valid_regex) || input.blank?
        errors.add(:input, " is invalid")
      end
    end
end
