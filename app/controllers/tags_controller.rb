class TagsController < ApplicationController
  before_action :set_model, only: [:show, :update, :destroy]

  # GET /tags
  # GET /tags.json
  def index
    @search = Search.new(params[:search])
    @models = @search.filter(results: Tag.all, filter_attrs: [:title, :description, :code])
  end

  # GET /tags/1
  # GET /tags/1.json
  def show
  end

  # POST /tags
  # POST /tags.json
  def create
    @model = Tag.new(model_params)
    respond_to do |format|
      if @model.save
        format.json { render :show, status: :created, location: @model }
      else
        format.json { render json: @model.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /tags/1
  # PATCH/PUT /tags/1.json
  def update
    if @model.update(model_params)
      render json: @model
    else
      render json: @model.errors, status: :unprocessable_entity
    end
  end

  # DELETE /tags/1
  # DELETE /tags/1.json
  def destroy
    @model.destroy
    respond_to do |format|
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_model
      @model = Tag.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def model_params
      @model_params ||= params.require(:tag).permit(:code, :title, :description, :admin, :apply_only_by_admin, :apply_by_default)
    end
end
