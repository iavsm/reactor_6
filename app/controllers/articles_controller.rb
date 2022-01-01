class ArticlesController < ApplicationController

  before_action :set_article, only: [:show, :edit, :update, :destroy]
  before_action :required_user, except: [:show, :index]
  before_action :required_same_user, only: [:edit, :destroy, :update]
  
  def show
     
  end

  def index
      @article = Article.paginate(page: params[:page], per_page: 1)
  end

  def new
    @article = Article.new
  end

  def create
    @article = Article.new(get_params)
    @article.user = current_user
      if @article.save
        flash[:notice] = 'Article created sucessfully'
        redirect_to article_path(@article)
      else 
        render 'new'
      end    
  end

  def edit
  end

  def update
      if @article.update(get_params)
        flash[:notice] = 'Article updated sucessfully'
        redirect_to article_path(@article)
      else 
        render 'new'
      end  
  end

  def destroy
    @article.destroy
    redirect_to articles_path
  end

  private

    def set_article
      @article = Article.find(params[:id])
    end

    def get_params
      params.require(:article).permit(:title, :description)
    end

    def required_same_user
      if current_user != @article.user
        flash[:alert] = "You can only edit and delete your own article"
        redirect_to @article
      end
    end       

end