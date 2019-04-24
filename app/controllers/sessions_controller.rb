class SessionsController < ApplicationController

  skip_before_action :require_login
  skip_before_action :require_admin
  before_action :require_login, only: [:destroy]
  before_action :check_jwt_request

  def index
    #set_locale_from_header

    login_successful and return if current_user && !params[:force_login] && !current_client_service&.force_login

    respond_to do |format|
      format.json do
        if authenticate_or_request_with_http_basic { |user_name, password| login(user_name, password) }
          set_token
        end
      end
      format.html do
        render :index
      end
    end
  end

  def create
    if login(params[:user_name], params[:password])
      session[:user_id] = current_user.id if Rails.configuration.use_session
      login_successful
    else
      respond_to do |format|
        format.html do
          flash[:notice] = I18n.t "login_failed"
          render action: "index"
        end
        format.json do
          render json: "login_failed", status: 401
        end
      end
    end
  end

  def destroy
    #Kill off current session
  end

  def check_jwt_request
    return unless current_client_service
    if params[:jwt_request]
      @client_service.decode_jwt_request(params[:jwt_request])
      @jwt_request = params[:jwt_request]
    elsif @client_service.require_signed_request
      raise ApplicationController::NotAuthorized.new
    end
  end

  def login(user_name, password)
    user = User.find_by("user_name=? or email=?", user_name, user_name)
    if user && user.authenticate(password)
      @current_user = user
      true
    else
      false
    end
  end

  def current_user
    return @current_user if @current_user.present?
    if Rails.configuration.use_session && session[:user_id]
      @current_user = User.find_by_id(session[:user_id])
    end
    if current_client_service && params[:token]
      token = @client_service.decode_jwt_token(params[:token])
      @current_user = User.find_by_id(token.user_id)
    end
  end

  def login_successful
    if current_client_service
      @token = @client_service.encode_jwt_token(@current_user)
      respond_to do |format|
        format.html do
          redirect_to @client_service.token_access_url(@token)
        end
        format.json do
          render :token, :ok
        end
      end
    else
      respond_to do |format|
        format.html do
          flash[:notice] = I18n.t "login_successful"
          redirect_to action: "index"
        end
        format.json do
          render json: "login_successful"
        end
      end
    end

  end
end
