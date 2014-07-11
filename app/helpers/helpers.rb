helpers do

  def current_user
   #returns the current user if there is a user signed in.
    if session[:user_id]
      User.find(session[:user_id])
    end
  end

end
