module SessionsHelper


  def admin_user
    redirect_to root_path unless current_user.admin?
  end

  def log_in(user)
    cookies.permanent[:remember_token] = user.remember_token
    current_user = user
  end

  def current_user=(user)
    @current_user = user
  end

  def current_user
    @current_user ||= user_from_remember_token
  end

  def current_user?(user)
    current_user == user
  end

  def loged_in?
    !current_user.nil?
  end

  def log_out
    current_user = nil
    cookies.delete(:remember_token)
  end

  def redirect_back_or(default)
    redirect_to(session[:return_to] || default)
    clear_return_to
  end

  def store_location
    session[:return_to] = request.fullpath
  end

  def loged_in_user
    unless loged_in?
      store_location
      redirect_to login_path, notice: "Porfavor registrate!!" 
    end
  end

  def set_place(place)
    session[:place_id] = place.id
    current_place = place
  end

  def current_place=(place)
    @current_place = place
  end

  def current_place
    @current_place ||= place_from_session
  end

  def current_view=(view)
    # @current_view = view
  end

  def current_view
    
  end


  private

    def user_from_remember_token
      remember_token = cookies[:remember_token]
      User.find_by_remember_token(remember_token) unless remember_token.nil?
    end

    def clear_return_to
      session.delete(:return_to)
    end

    def place_from_session
      place_id = session[:place_id]
      Place.find_by_id(place_id) unless place_id.nil?
    end
end
