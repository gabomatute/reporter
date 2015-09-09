class Admin::ReportTypesController < AdminController
  before_action :set_report_type, only: [:show, :edit, :update, :destroy]

  # GET /report_types
  # GET /report_types.json
  def index
    @report_types = ReportType.all
  end

  # GET /report_types/1
  # GET /report_types/1.json
  def show
  end

  # GET /report_types/new
  def new
    @report_type = ReportType.new
    @report_type.fields.build
  end

  # GET /report_types/1/edit
  def edit
  end

  # POST /report_types
  # POST /report_types.json
  def create
    @report_type = ReportType.new(report_type_params)

    respond_to do |format|
      if @report_type.save
        format.html { redirect_to [:admin, @report_type], notice: 'Report was successfully created.' }
        format.json { render :show, status: :created, location: @report_type }
      else
        format.html { render :new }
        format.json { render json: @report_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /report_types/1
  # PATCH/PUT /report_types/1.json
  def update
    respond_to do |format|
      if @report_type.update(report_type_params)
        format.html { redirect_to [:admin, @report_type], notice: 'Report Type was successfully updated.' }
        format.json { render :show, status: :ok, location: @report_type }
      else
        format.html { render :edit }
        format.json { render json: @report_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /report_types/1
  # DELETE /report_types/1.json
  def destroy
    @report_type.destroy
    respond_to do |format|
      format.html { redirect_to admin_report_types_url, notice: 'Report Type was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_report_type
      @report_type = ReportType.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def report_type_params
      params.require(:report_type).permit(:name, :category_id, :database_id, :description, :sql, fields_attributes: [:id, :name, :field_type_id, :required, :placeholder, :_destroy])
    end
end
