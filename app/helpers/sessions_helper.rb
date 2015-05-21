module SessionsHelper
  #logs in the current user
  def log_in(user)
    session[:user_id]=user.id
  end

  #get current logged-in user
  def current_user
    if (user_id=session[:user_id])
      @current_user||= User.find_by(id: session[:user_id])
    elsif (user_id=cookies.signed[:user_id])
      #next time when log in, can get user information from cookies
      user=User.find_by(id: user_id)
      if user && user.authenticated?(cookies[:remember_token])
        log_in user
        @current_user=user
      end
    end
  end

  def logged_in?
    !current_user.nil?
  end

  def log_out
    #add by fionhan on 2015-5-20 to clear cookies in broswer,
    # because if not, :user_id will not be nil and session[:user_id] will always not be nil,
    #so the user will never log out,and the user_login_test.rb faild
    forget current_user if !current_user.nil?
    session.delete(:user_id)
    @current_user=nil
  end

  def remember(user)
    user.remember
    cookies.permanent.signed[:user_id]=user.id
    cookies.permanent[:remember_token]=user.remember_token
  end

  # Forgets a persistent user information in cookies
  def forget(user)
    user.forget
    cookies.delete(:user_id)
    cookies.delete(:remember_token)
  end

  def current_user?(user)
    user==current_user
  end

  def redirect_back_or(default)
    redirect_to(session[:forwarding_url] || default)
    session.delete(:forwarding_url)
  end

  def store_location
    session[:forwarding_url]=request.url if request.get
  end
end
