class UsersController < ApplicationController

    def new
        @user = User.new    
    end    

    def create
        @user = User.new(get_params)
        if @user.save
           flash[:notice] = "Welcome to Reactor6"
           redirect_to articles_path
        else 
            render 'new'
        end    
    end
    
    
    private

    def get_params
      params.require(:user).permit(:username, :email, :password_digest)
    end

end