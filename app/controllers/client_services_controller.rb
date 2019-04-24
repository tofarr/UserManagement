class ClientServicesController < ApplicationController
  before_action :set_model, only: [:show, :update, :destroy]

  # GET /client_services
  # GET /client_services.json
  def index
    @models = ClientService.all
  end

  # GET /client_services/1
  # GET /client_services/1.json
  def show
  end

  # POST /client_services
  # POST /client_services.json
  def create
    @model = ClientService.new(model_params)

    respond_to do |format|
      if @model.save
        format.json { render :show, status: :created, location: @model }
      else
        format.json { render json: @model.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /client_services/1
  # PATCH/PUT /client_services/1.json
  def update
    respond_to do |format|
      if @model.update(model_params)
        format.json { render :show, status: :ok, location: @model }
      else
        format.json { render json: @model.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /client_services/1
  # DELETE /client_services/1.json
  def destroy
    @model.destroy
    respond_to do |format|
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_model
      @model = ClientService.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def model_params
      params.require(:client_service).permit(:secret, :algorithm, :token_timeout, :expire_at, :suspended, :tag_id)
    end
end
