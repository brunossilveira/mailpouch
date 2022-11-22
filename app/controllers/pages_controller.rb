class PagesController < ApplicationController
  def show
    render template: "pages/#{params[:page]}"
  rescue ActionView::MissingTemplate
    raise ActionController::RoutingError, "No such page: #{params[:page]}"
  end
end
