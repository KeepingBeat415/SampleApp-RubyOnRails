class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def show
    @user = User.find(params[:id])
  end

  def create
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        log_in @user
        flash[:success] = "Welcome to the Sample App!"
        format.html { redirect_to user_url(@user) }
        format.json { render :show, status: :created, location: @user }
      else
        #render 'new'
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
  end
  end

  private 
  
    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end

end
