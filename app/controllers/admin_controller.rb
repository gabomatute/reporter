class AdminController < ApplicationController
  # Enables common functionality among Admin::*Controllers,
  # including the default layout 'admin' for related controllers.
  before_action :authenticate_admin!

  def authenticate_admin!
    render plain: "You (#{current_user.name.titleize}) are not an admin", status: :unauthorized unless current_user.admin
  end
end
