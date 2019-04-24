class ApplicationController < ActionController::API

  before_action :require_login, only: [:index, :show]
  before_action :require_admin, only: [:create, :update, :destroy]


  NotAuthorized = Class.new(StandardError)

  rescue_from ApplicationController::NotAuthorized do |exception|
    render_error_page(status: 403, text: 'Forbidden')
  end

  def current_user
    puts "NOPE!!! WE NEED A LOGIN HERE!!!"
    @current_user ||= User.first
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
