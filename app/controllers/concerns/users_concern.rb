module UsersConcern
  extend ActiveSupport::Concern

  included do
    
    skip_before_action :require_login #Controller handles this in a custom way
    skip_before_action :require_admin #Controller handles this in a custom way

    before_action :check_index_authorization, only: [:index]
    before_action :check_show_authorization, only: [:show]
    before_action :check_create_authorization, only: [:create]
    before_action :check_update_authorization, only: [:update]
    before_action :check_destroy_authorization, only: [:destroy]
  end

  def check_index_authorization
    if current_user
      raise ApplicationController::NotAuthorized.new() unless current_user.admin? || (!Rails.configuration.user_profiles_private)
    else
      raise ApplicationController::NotAuthorized.new() unless Rails.configuration.user_profiles_public
    end
  end

  def check_show_authorization
    return if Rails.configuration.user_profiles_public #It's all good...
    raise ApplicationController::NotAuthorized.new() unless current_user
    raise ApplicationController::NotAuthorized.new() unless current_user.admin? ||
      (current_user == @model) ||
      (!Rails.configuration.user_profiles_private)
  end

  def check_create_authorization
    raise ApplicationController::NotAuthorized.new() unless current_user&.admin? || Rails.configuration.users_can_create_self
  end

  def check_update_authorization
    raise ApplicationController::NotAuthorized.new() unless current_user&.admin? || (Rails.configuration.users_can_update_self && current_user == @model)
  end

  def check_destroy_authorization
    raise ApplicationController::NotAuthorized.new() unless current_user&.admin? || (Rails.configuration.users_can_destroy_self && current_user == @user)
  end
end
