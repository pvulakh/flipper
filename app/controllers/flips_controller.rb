class FlipsController < ApplicationController

    # before_action is a callback, runs prior to executing a method
    before_action :ensure_logged_in, only: [:new, :edit, :update, :create, :destroy]

    def set_cookie
      maybe_cookie = params[:my_cookie]
      if maybe_cookie
        debugger
        flash[:my_cookie] = maybe_cookie
        debugger
        render plain: "I am setting your cookie: #{flash[:my_cookie]}"
      else
        render plain: "No cookie provided!"
      end
    end

    def get_cookie
      maybe_cookie = flash[:my_cookie]
      if maybe_cookie
        render plain: "I remember you! Here is your cookie: #{flash[:my_cookie]}"
      else
        render plain: "No cookie has been set! Who are you!?"
      end
    end
    # By convention, index returns all info pertaining to all instances of a resource
    # How to selectively render some but not all information? Stay tuned
    # Don't need to explicitly require model definitions or gems
    # controllers should be relatively sparse, our models do the heavy lifting in fetching and processing data
    def index
        # debugger
        # includes avoids separately querying for author when we loop through the flips, saving us a N+1 query
        # includes eagerly loads the information specific to the association passed
        # joins would join two tables together from which we would still have to select the columns we wanted
        @flips = Flip.all.includes(:author) # instance variables are accessible in our views
        # render json: flips  # render method takes in options hash specifying how to format flips data
        # render :tester # renders the tester.html.erb file
        render :index # optional, controller default renders view w/ same name as method
    end

    def show
        # debugger
        @flip = Flip.find(params[:id])
        # render json: flip
        render :show
    end

    def create
        # debugger
        # flip = Flip.new(flip_params)
        flip = current_user.authored_flips.new(flip_params) # grab the first user, go to their flips, and make a new flip within their flips
        # going into the first user's authored flips automatically sets the flip's author_id to 1
        if flip.save
            # debugger
            # render json: flip
            # takes us to the show action and then the show.html.erb
            redirect_to flip_url(flip)  # here, Rails extracts the id from the flip object
            # redirect_to flip_url(flip.id)  # this also works
        else
            # debugger
            render json: flip.errors.full_messages, status: :unprocessable_entity   # or 422 for status code
        end
    end

    def update
        # debugger
        flip = Flip.find(params[:id])
        # flip doesn't need to be an instance variable here because we aren't rendering a html.erb file
        # we're redirecting to the show action which takes care of rendering a view for us
        if flip.update(flip_params)
            # render json: flip
            redirect_to flip_url(flip)
        else
            render json: flip.errors.full_messages, status: 422
        end
    end

    def destroy
        flip = current_user.authored_flips.find_by(id: params[:id])
        if flip
            # debugger
            flip.destroy
            redirect_to flips_url # goes to index action which then renders index page
        else
            render json: 'Flip not found', status: 404
        end
    end

    def new # although this method may be empty, we still need the method signature
        # otherwise, there won't be a controller action to handle the route
        @flip = Flip.new # this allows us to call @flip.body without erroring out, it would just return nil which wouldn't print anything
        # debugger
        render :new
        # can omit render :new b/c the new action will default render new.html.erb
    end

    def edit
        @flip = Flip.find(params[:id]) # find throws an ActiveRecordNotFound Exception if the flip is not found
        # an ActiveRecordNotFound Exception is different from a 404 status code
        # @flip = Flip.find_by(id: params[:id]) # using find_by returns null if the record is not found
        # this allows us to use conditional logic for a certain error status code, e.g. 404
        render :edit
    end

    private 

    def flip_params
        # debugger
        params.require(:flip).permit(:body, :author_id)
    end

    # strong params: enforces rules on information that we accept from user
    # filter incoming params for only the info we want to persist in the DB
end