class UsersController < ApplicationController
    def new
        render :new
    end

    # signs a user up
    def create
        @user = User.new(user_params)
        @user.location = Location.first
        # debugger
        if @user.save
            # debugger
            login!(@user)
            # debugger
            redirect_to flips_url
        else
            # debugger
            flash.now[:errors] = @user.errors.full_messages
            render :new
        end
    end

    private

    def user_params
        params.require(:user).permit(:username, :password)
    end
end