module ApplicationHelper
  def auth_administrator!
    redirect_to new_user_session_path unless current_user.roles.include?('administrator')
  end
end
