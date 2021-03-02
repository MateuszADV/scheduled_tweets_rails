class PasswordResetsController < ApplicationController
    def new
    end

    def create
        @user = User.find_by(email: params[:email])

        if @user.present?
            # send emali
            PasswordMailer.with(user: @user).reset.deliver_now
            redirect_to root_path, notice: "Na podany mail zostal wysłany link do resetu hasla."
        # else
        #     redirect_to root_path, notice: "Podany email istnieje w bazie, został wysłany link do resetu hasla."
        end
    end

    def edit 
        @user = User.find_signed(params[:token], purpose: "password_reset")
        # binding.irb wyswie
    rescue ActiveSupport::MessageVerifier::InvalidSignature
        redirect_to sign_in_path, alert: " Twoj token wygasl, ponow probę ponownie"
    end

    def update
        @user = User.find_signed!(params[:token], purpose: "password_reset")
        if @user.update(password_params)
            redirect_to sign_in_path, notice: " twoje haslo zostalo zmienione. Zaloguj sie"
        else
            render :edit
        end
    end

    private

    def password_params
        params.require(:user).permit(:password, :password_confirmation)
    end
end