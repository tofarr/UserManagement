class UsersController < ApplicationController

  include UsersConcern
  before_action :set_model, only: [:show, :update, :destroy]

  # GET /users
  # GET /users.json
  def index
    @search = Search::UserSearch.new(params[:search])
    @models = @search.search
  end

  # GET /users/1
  # GET /users/1.json
  def show
  end

  # POST /users
  # POST /users.json
  def create
    @model = User.new(model_params)
    attach_img(@model, params.require(:user), :avatar)
    respond_to do |format|
      if @model.save
        format.json { render :show, status: :created, location: @model }
      else
        format.json { render json: @model.errors, status: :unprocessable_entity }
      end
    end

  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    @model.assign_attributes(model_params)
    attach_img(@model, params.require(:user), :avatar)
    if @model.update(model_params)
      render json: @model
    else
      render json: @model.errors, status: :unprocessable_entity
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @model.destroy
    respond_to do |format|
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_model
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def model_params
      @model_params ||= params.require(:user).permit(:user_name, :full_name, :email, :password_digest, :password, :password_confirmation)
    end
end
