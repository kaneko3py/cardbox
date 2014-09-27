class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  # private
  # def required_login
  #   unless current_user
  #     respond_to do |format|
  #       format.html { redirect_to '/' }
  #       format.json { head 401 }
  #     end
  #   end
  #   true
  # end

  # # private
  # # def required_admin
  # #   return true if Rails.env == 'development'
  # #   unless current_user && current_user.is_admin?
  # #     respond_to do |format|
  # #       format.html { head 404 }
  # #     end
  # #   end
  # #   true
  # # end

  # private
  # def current_user
  #   return @current_user if @current_user
  #   return nil if @current_user === false
  #   # user = User.where(:id => session[:authorized_user_id]).first
  #   user = User.find(1)
  #   @current_user = user && user.lock? ? false : user
  # end

end
