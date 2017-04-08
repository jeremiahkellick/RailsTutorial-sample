class SessionsController < ApplicationController

  def new
  end

  def create
    @user = User.find_by(email: params[:session][:email].downcase)
    if(@user)
      if(@user.authenticate(params[:session][:password]))
        log_in @user
        params[:session][:remember_me] == '1' ? remember(@user) : forget(@user)
        redirect_to @user
      else
        flash.now[:danger] = 'Incorrect password for ' + params[:session][:email]
        render 'new'
      end
    else
      flash.now[:danger] = 'No account with that email exists.'
      render 'new'
    end
  end

  def destroy
    log_out
    redirect_to root_url
  end

end
