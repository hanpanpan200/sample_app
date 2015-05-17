module UsersHelper
  #Return gravatar for the given user
  def gravatar_for(user,size)
    gravatar_id=Digest::MD5::hexdigest(user.email.downcase)
    gravatar_url="https://secure.gravatar.com/avatar/#{gravatar_id}"
    if size.empty?
    image_tag(gravatar_url,alt:user.name,class:"gravatar")
    else
    image_tag(gravatar_url,alt:user.name,class:"gravatar",size:size)
  end
  end
  end
