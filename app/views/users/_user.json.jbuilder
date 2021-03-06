json.extract! user, :id, :user_name, :full_name, :email, :settings, :created_at, :updated_at
json.password_digest user.password_digest if @current_user&.admin?
json.avatar_url user.avatar.attachment ? url_for(user.avatar) : nil
