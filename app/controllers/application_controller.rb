class ApplicationController < ActionController::Base

  before_action :require_login, only: [:index, :show]
  before_action :require_admin, only: [:create, :update, :destroy]


  NotAuthorized = Class.new(StandardError)

  rescue_from ApplicationController::NotAuthorized do |exception|
    respond_to do |format|
      format.html do
        render :file => 'public/403.html', :status => 403, :layout => false
      end
      format.json do
        render json: "forbidden", status: 403
      end
    end
  end

  def current_client_service
    if (!@client_service) && params[:client_service_id]
      @client_service = ClientService.find(params[:client_service_id])
      raise ApplicationController::NotAuthorized.new unless @client_service.active?
    end
    @client_service
  end

  def current_user
    return @current_user if @current_user.present?
    if Rails.configuration.use_session && session[:user_id]
      @current_user = User.find_by_id(session[:user_id])
      return @current_user
    end
    if current_client_service && params[:token].present?
      token = @client_service.decode_jwt_token(params[:token])
      @current_user = User.find_by_id(token.user_id)
      session[:user_id] = @current_user&.id if Rails.configuration.use_session
    end
    @current_user
  end

  def require_login
    raise ApplicationController::NotAuthorized unless current_user || Rails.configuration.meta_public
  end

  def require_admin
    raise ApplicationController::NotAuthorized unless current_user&.admin?
  end

  def process_img(model, model_params, attr_sym)
    if model_params["destroy_#{attr_sym}".to_sym]
      attr = model.send(attr_sym)
      attr.purge if attr.attached?
      return
    end
    f = model_params[attr_sym]
    if f
      if f.class.name == 'String' && f.starts_with?('data:') # String was sent - manually convert to file
        uri = URI::Data.new(f)
        extension = MIME::Types[uri.content_type].first.extensions.first
        model.send(attr_sym).attach(io: StringIO.new(uri.data), filename: "upload.#{extension}")
      else
        model.send(attr_sym).attach(f)
      end
    end
  end

end
