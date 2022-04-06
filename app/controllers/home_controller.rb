class HomeController < ApplicationController
  before_action :redirect_if_authenticated

  def index; end;

  def redirect_if_authenticated
    redirect_to inbox_index_path if current_user
  end
end
