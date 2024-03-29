class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      # Log the user in and redirect to the user's show page.
      #session[:current_user_id] = user.id
      log_in user
      #remember user
      params[:session][:remember_me] == '1' ? remember(user) : forget(user)
      redirect_to current_user
    else
      # Create an error message.
      flash.now[:danger] = 'Invalid email/password combination' #Not quite right!
      render action: 'new'
    end
  end

  def destroy
    log_out if logged_in?
    redirect_to root_url
  end
end
