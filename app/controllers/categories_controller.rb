class CategoriesController < ApplicationController

  before_action :admin_required, except: %i[index show]

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(category_params)
    if @category.save
      flash[:notice] = "Category was successfully created"
      redirect_to @category
    else
      render 'new'
    end
  end

  def index
    @categories = Category.paginate(page: params[:page], per_page: 1)
  end

  def show
    @category = Category.find(params[:id])
    @article = @category.article.paginate(page: params[:page], per_page: 1)
  end

  def edit
   @category = Category.find(params[:id])
  end
  
  def update
    @category = Category.find(params[:id])
    if @category.update(category_params)
      flash[:notice] = "Category name updated succesfully"
      redirect_to @category
    else 
      render category_edit
    end    
   end
  
  private

  def category_params
    params.require(:category).permit(:name)
  end

  def admin_required
    if !(logged_in? && current_user.admin?)
      flash[:alert] = 'Only admin can create the category'
      redirect_to categories_path
    end
  end  
end

