module UserHelper
  def user_profile_image(user, klass:)
    gravatar_id = Digest::MD5::hexdigest(user.email.downcase)
    gravatar_url = "http://secure.gravatar.com/avatar/#{gravatar_id}?d=mp"

    image_tag(gravatar_url, alt: user.email, class: klass)
  end

  def user_mailpouch_email_address
    "#{current_user.username}@inbox.mailpouch.app"
  end
end
