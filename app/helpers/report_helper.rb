module ReportHelper
  def tailored_field (builder, field_input)
    case field_input.field.field_type.data_type
    when "int"
      builder.number_field :input, class: "form-control"
    when "float"
      builder.number_field :input, class: "form-control", step: "0.01"
    when "bool"
      builder.select :input, [["True", true], ["False", false]], {}, class: "form-control"
    when "date"
      builder.text_field :input, class: "form-control", data: {
            provide: "datepicker",
            :"date-format" => "mm-dd-yyyy"
          }
    else
      builder.text_field :input, class: "form-control"
    end
  end
end
