class ReportsController < ApplicationController
  # GET /reports/select
  def select
    @report_types = ReportType.all
  end

  # GET /reports/new
  def new
    @report = Report.new(report_type_id: params[:report_type_id])
    @report.build_field_inputs
  end

  # POST /reports
  def create
    @report = Report.new(report_params)

    respond_to do |format|
      if @report.generate
        format.html { render :show }
        format.csv { send_data @report.to_csv, filename: "Report - #{@report.report_type.name}", type: :csv }
      else
        format.html { render :new }
        format.csv { head :unprocessable_entity }
      end
    end
  end

  private
    # Never trust parameters from the scary internet, only allow the white list through.
    def report_params
      params.require(:report).permit(:report_type_id, field_inputs_attributes: [:field_id, :input])
    end
end
