class RegistrationsController < ApplicationController
def new
    @user = User.new    
end

def create
    # render plain: "Thanks"
    # render plain: params[:user]
    # {"email"=>"mateusz.adv@gmail.com", "password"=>"password", "password_confirmation"=>"password"}
    @user = User.new(user_params)
    if @user.save
        session[:user_id] = @user.id
        redirect_to root_path, notice: "Successfull create accont"
    else
        # falsh[:alert] = "Some thing was wrong"
        render :new
    end 
end

private
def user_params
    params.require(:user).permit(:email, :password, :password_confirmation)
end    
end