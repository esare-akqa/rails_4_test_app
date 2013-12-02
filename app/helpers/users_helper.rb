module UsersHelper
  # Returns the Gravatar (http://gravatar.com/) for the given user.
  def gravatar_for(user, options = { size: 50 })
    gravatar_id = Digest::MD5::hexdigest(user.email.downcase)
    # gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}"
    # gravatar_base_url = "https://secure.gravatar.com/avatar/#{gravatar_id}"
    gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}?#{options.to_query}" 
    image_tag(gravatar_url, alt: user.name, class: 'gravator')
  end
end
