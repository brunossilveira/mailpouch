class NewsletterMessagesController < ApplicationController
  before_action :authenticate_user!
  before_action :redirect_if_not_subscribed

  def show
    @newsletter_message = NewsletterMessage.find_by!(id: params[:id], user: current_user)
    @newsletter_message.update(read: true)

    # ActionView::Base.full_sanitizer.sanitize(@newsletter_message.body, tags: %w(img br p span table tr td tbody))

    scrub = Loofah::Scrubber.new do |node|
      node.name = "p" if node.name == "td"
      node.name = "div" if node.name == "table"
      node.name = "div" if node.name == "tbody"
    end

    @sanitized_body = Loofah.fragment(@newsletter_message.body)
      .scrub!(:prune)
      .scrub!(:strip)
      .scrub!(:escape)
      .scrub!(:whitewash)
      .scrub!(scrub)
      .to_s.html_safe

    @blah = @newsletter_message.body
  end

  def read
    @newsletter_message = NewsletterMessage.find_by!(id: params[:id], user: current_user)
    @newsletter_message.update(read: true)

    redirect_to inbox_index_path
  end

  private

  def redirect_if_not_subscribed
    if current_user && !current_user.subscribed?
      redirect_to root_path
    end
  end
end
