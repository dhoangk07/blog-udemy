class ArticlesController < ApplicationController
  before_action :set_article ,only: [:edit, :update, :show, :destroy]
  skip_before_action :authenticate_user!, only: [:index, :show]
  def index
    @articles = if params[:tag]
      @articles = Article.tagged_with(params[:tag])
    else
      @articles = Article.all
    end
    if params[:search].present?
      @articles = @articles.search(params[:search])
    end
  end

  def show
  end

  def new
    @article = Article.new
  end

  def edit
  end

  def create
    #render plain: params[:article].inspect
    @article = Article.new(article_params)
    if @article.save
      flash[:success] = "Article was successfully created"
      redirect_to @article
    else
      render 'new'
    end
  end

  def update
      flash[:success] = "Article was successfully updated"
    if @article.update(article_params)
      redirect_to @article
    else
      render 'edit'
    end
  end

  def destroy
    @article.taggings.where(:article => params[:id]).first.destroy
    @article.destroy
      flash[:danger] = "Article was successfully destroyed"
    redirect_to articles_path
  end

  private
    def set_article
      @article = Article.find(params[:id])
    end

    def article_params
      params.require(:article).permit(:title, :text, :user_id, :tag_list, :search)
    end 
end



