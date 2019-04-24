class UserTagsController < ApplicationController

  include UsersConcern
  before_action :set_model, only: [:show, :update, :destroy]

  # GET /user_tags
  # GET /user_tags.json
  def index
    @search = Search::UserTagSearch.new(params[:search])
    @models = @search.search
    render json: {search: @search, results: @models}
  end

  # GET /user_tags/1
  # GET /user_tags/1.json
  def show
    render json: @model
  end

  # POST /user_tags
  # POST /user_tags.json
  def create
    @model = UserTag.new(model_params)
    if @model.save
      render json: @model, status: :created, location: @model
    else
      render json: @model.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /user_tags/1
  # PATCH/PUT /user_tags/1.json
  def update
    if @model.update(model_params)
      render json: @model
    else
      render json: @model.errors, status: :unprocessable_entity
    end
  end

  # DELETE /user_tags/1
  # DELETE /user_tags/1.json
  def destroy
    @model.destroy
    respond_to do |format|
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_model
      @model = UserTag.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def model_params
      @model_params ||= params.require(:user).permit(:user_id, :tag_id)
    end
end
