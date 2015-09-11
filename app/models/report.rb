class Report
  # Tableless Model
  include Tableless

  belongs_to :report_type
  has_many :field_inputs

  column :data

  accept_nested_attributes_for :field_inputs

  validates :report_type, presence: true
  validate :field_input_validity, :fields_correspond

  # Declares attributes for ActiveModel::Serialization meth od serializable_hash
  def attributes
    {'report_type_id' => nil, 'field_inputs_attributes' => nil}
  end

  # Build field_inputs from report_type fields
  def build_field_inputs
    self.field_inputs = report_type.fields.map { |field| FieldInput.new(report: self, field: field) }
  end

  # Generate data if report is valid
  def generate
    if valid?
      @data = @report_type.database.connect_to_exec(query)
      # If no data returns there must have been an error connecting to db
      errors.add(:base, "Error connecting to database") unless @data
      # Returns data
      @data
    else
      false
    end
  end

  # Returns a Hash with all the field_input replacements
  def replacements
    field_inputs.each_with_object({}) do |field_input, replace|
      replace.merge!(field_input.replacement)
    end
  end

  # Construct the query by filling in the placeholders
  def query
    report_type.sql.gsub(/\?\?.*?\?\?/, replacements)
  end

  private
    def fields_correspond
      if field_inputs.map { |field_input| field_input.field } != report_type.fields
        errors.add(:field_inputs, "do not correspond to Report Type fields")
      end
    end

    def field_input_validity
      field_inputs.each do |field_input|
        unless field_input.valid?
          field_input.errors.full_messages.each do |msg|
            errors.add(:base, "#{field_input.field.name} field error: #{msg}")
          end
        end
      end
    end
end
