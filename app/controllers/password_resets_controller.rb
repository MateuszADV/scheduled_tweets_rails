class PasswordResetsController < ApplicationController
    def new

    end

    def create
        @user = User.find_by(email: params[:email])

        if @user.present?
            # send emali
            PasswordMailer.with(user: @user).reset.deliver_now
            redirect_to root_path, notice: "Na podany mail został wysłany link do resetu hasla."
        else
            redirect_to root_path, notice: "Podany email istnieje w bazie, został wysłany link do resetu hasla."
        end
    end
end