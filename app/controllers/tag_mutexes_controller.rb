class TagMutexesController < ApplicationController
  before_action :set_model, only: [:show, :update, :destroy]

  # GET /tag_mutexes
  # GET /tag_mutexes.json
  def index
    @search = Search::TagMutexSearch.new(params[:search])
    @models = @search.search
    render json: {search: @search, results: @models}
  end

  # GET /tag_mutexes/1
  # GET /tag_mutexes/1.json
  def show
    render json: @model
  end

  # POST /tag_mutexes
  # POST /tag_mutexes.json
  def create
    @model = TagMutex.new(model_params)
    if @model.save
      render json: @model, status: :created, location: @model
    else
      render json: @model.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /tag_mutexes/1
  # PATCH/PUT /tag_mutexes/1.json
  def update
    if @model.update(model_params)
      render json: @model
    else
      render json: @model.errors, status: :unprocessable_entity
    end
  end

  # DELETE /tag_mutexes/1
  # DELETE /tag_mutexes/1.json
  def destroy
    @model.destroy
    respond_to do |format|
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_model
      @model = TagMutex.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def model_params
      @model_params ||= params.require(:tag_mutex).permit(:tag_a_id, :tag_b_id)
    end
end
