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

    def edit
        @user = User.find(params[:id])
    end 
    
    def update
        @user = User.find(params[:id])
        if @user.update(get_params)
            flash[:notice] = "User updated successfully"
        else 
            render "edit"
        end        
    end 
    
    
    private

    def get_params
      params.require(:user).permit(:username, :email, :password_digest)
    end

end