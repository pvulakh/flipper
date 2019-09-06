class SessionsController < ApplicationController
    def new
        render :new
    end

    # logs a user in
    def create
        user = User.find_by_credentials(params[:user][:username], params[:user][:password])
        if user
            login!(user)
            redirect_to flips_url
        else
            # below, we use flash.now b/c we're rendering the response
                # flash.now persists only for the current req/res cycle
            # if we were redirecting, we'd want to use flash (which persists for the current and next req/res cycle)
            flash.now[:errors] = ["Invalid credentials"]
            # debugger
            render :new
        end
    end

    # logs a user out
    def destroy
        # debugger
        logout!
        # debugger
        redirect_to flips_url
    end
end