class SessionsController < ApplicationController
    def new

    end

    def create
        user = User.find_by(email: params[:email])
        if user.present? && user.authenticate(params[:password])
            session[:user_id] = user.id
            redirect_to root_path, notice: "Logowanie zakończone powodzeniem"
        else
            flash[:alert] = "Nipoprawny email lub hasło"
            render :new
        end    
    end


    def destroy
        session[:user_id] = nil
        redirect_to root_path, notice: "Logged out"
    end
end