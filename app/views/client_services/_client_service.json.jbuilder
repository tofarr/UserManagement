json.extract! client_service, :id, :secret, :algorithm, :token_timeout, :expire_at, :suspended, :created_at, :updated_at
json.secret_key client_service.secret_key if @current_user&.admin?
json.icon_url client_service.icon.attachment ? url_for(client_service.icon) : nil
