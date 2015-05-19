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
    @current_user.nil?
  end

  def log_out
    session.delete(:user_id)
    @current_user=nil
  end

  def remember(user)
    user.remember
    cookies.permanent.signed[:user_id]=user.id
    cookies.permanent[:remember_token]=user.remember_token
  end

  # Forgets a persistent session.
  def forget(user)
    user.forget
    cookies.delete(:user_id)
    cookies.delete(:remember_token)
  end
end
