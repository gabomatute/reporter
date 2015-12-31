class Admin::DatabasesController < AdminController
  before_action :set_database, only: [:show, :edit, :update, :destroy]

  # GET /databases
  # GET /databases.json
  def index
    @databases = Database.all
  end

  # GET /databases/1
  # GET /databases/1.json
  def show
  end

  # GET /databases/new
  def new
    @database = Database.new
  end

  # GET /databases/1/edit
  def edit
  end

  # POST /databases
  # POST /databases.json
  def create
    @database = Database.new(database_params)

    respond_to do |format|
      if @database.save
        format.html { redirect_to [:admin, @database], notice: 'Database was successfully created.' }
        format.json { render :show, status: :created, location: @database }
      else
        format.html { render :new }
        format.json { render json: @database.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /databases/1
  # PATCH/PUT /databases/1.json
  def update
    respond_to do |format|
      if @database.update(database_params)
        format.html { redirect_to [:admin, @database], notice: 'Database was successfully updated.' }
        format.json { render :show, status: :ok, location: @database }
      else
        format.html { render :edit }
        format.json { render json: @database.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /databases/1
  # DELETE /databases/1.json
  def destroy
    respond_to do |format|
      if @database.destroy
        format.html { redirect_to admin_databases_url, notice: 'Database was successfully destroyed.' }
        format.json { head :no_content }
      else
        format.html { redirect_to admin_databases_url, alert: 'Database has associated reports.' }
        format.json { head :unprocessable_entity }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_database
      @database = Database.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def database_params
      params.require(:database).permit(:name, :database, :adapter, :host, :port, :username, :password)
    end
end
