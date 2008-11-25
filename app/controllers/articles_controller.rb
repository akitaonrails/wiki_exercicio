class ArticlesController < ApplicationController
  # GET /articles
  def index
    @articles = Article.find(:all)
  end
  # GET /articles/MeuLink/versions
  def versions
    @article = Article.find_by_title(params[:id])
    unless @article
      redirect_to new_article_url(:title => params[:id])
    else
      @versions = @article.versions.reverse
    end
  end
  # GET /articles/MeuLink
  def show
    @article = Article.find_by_title(params[:id])
    if params[:version]
      @revert_link = revert_article_path(params[:id], 
        :version => params[:version])
      @article = @article.versions.find(params[:version].to_i)
    end
    unless @article
      redirect_to new_article_url(:title => params[:id])
    end
  end
  # GET /articles/new
  def new
    @article = Article.new
    @article.title = params[:title] if params[:title]
  end
  # GET /articles/MeuLink/edit
  def edit
    @article = Article.find_by_title(params[:id])
    unless @article
      redirect_to new_article_url(:title => params[:id])
    end
  end
  # POST /articles/MeuLink/revert
  def revert
    @article = Article.find_by_title(params[:id])
    @article.revert_to(params[:version])
    if @article.save
      flash[:notice] = "Article reverted to version #{params[:version]}"
    end
    redirect_to(@article)
  end
  # POST /articles
  def create
    @article = Article.new(params[:article])
    if @article.save
      flash[:notice] = 'Article was successfully created.'
      redirect_to(@article)
    else
      render :action => "new"
    end
  end
  # PUT /articles/MeuLink
  def update
    @article = Article.find_by_title(params[:id])
    if @article.update_attributes(params[:article])
      flash[:notice] = 'Article was successfully updated.'
      redirect_to(@article)
    else
      render :action => "edit"
    end
  end
  # DELETE /articles/MeuLink
  def destroy
    @article = Article.find_by_title(params[:id])
    @article.destroy
    redirect_to(articles_url)
  end
end