class ArticlesController < ApplicationController

  before_action :set_article, only: [:show, :edit, :update, :destroy]
  
  def show
     
  end

  def index
      @article = Article.all
  end

  def new
    @article = Article.new
  end

  def create
    @article = Article.new(get_params)
    @article.user = User.first
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

end