module ApplicationHelper
  def unavatar_url(domain)
    "https://unavatar.io/#{domain}?fallback=https://source.boringavatars.com/pixel/42/2?colors=D95534,F0B17D,EDDD9F,1FB6CC,9AD4D3"
  end

  def unsubscribe_alert
    if current_user && !current_user.subscribed?
      "#{checkout_link} so you don't miss any newsletters!".html_safe
    end
  end

  private

  def checkout_link
    link_to 'Subscribe now', checkout_path, class: 'font-bold hover:underline hover:text-orange-600 cursor-pointer'
  end
end
