class PagesController < ApplicationController
  def show
    if params[:page].ends_with?("-newsletters")
      page = params[:page].gsub('-newsletters', '')

      redirect_to best_newsletters_path(category: page)
    else
      render template: "pages/#{params[:page]}"
    end
  rescue ActionView::MissingTemplate
    raise ActionController::RoutingError, "No such page: #{params[:page]}"
  end
end
