class PostsController < ApplicationController
  def index
    @posts = Post.all
  end
  
  def show
    @posts = Post.find(params[:id])
  end
  
  def new
    @posts = Post.new
  end
  
  def create
    @posts = Post.new(posts_params)
    
    if @posts.save
      redirect_to posts_path, :notice => "New company was added successfully"
    else
      render "new"
    end
  end
  
  def edit
    @posts = Post.find(params[:id])
  end
  
  def update
    @posts = Post.find(params[:id])
    
    if @posts.update_attributes(posts_params)
      redirect_to posts_path, :notice => "Company information was updated successfully"
    else
      render "edit", :notice => "Company information was not updated"
    end
  end
  
  def destroy
    @posts = Post.find(params[:id])
    @posts.destroy
    redirect_to posts_path, :notice => "The information was deleted"
  end
  
 
  
  private
    # Using a private method to encapsulate the permissible parameters is
    # just a good pattern since you'll be able to reuse the same permit
    # list between create and update. Also, you can specialize this method
    # with per-user checking of permissible attributes.
    def posts_params
      params.require(:post).permit(:name, :ticker, :description, :region, :website, :active)
    end
  
end
