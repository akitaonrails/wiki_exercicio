class ArticlesController < ApplicationController
  # GET /articles
  # GET /articles.xml
  def index
    @articles = Article.find(:all)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @articles }
    end
  end
  
  def versions
    @article = Article.find_by_title(params[:id])
    
    respond_to do |wants|
      unless @article
        wants.html { redirect_to new_article_url(:title => params[:id]) }
        wants.xml { head 404 }
      else
        @versions = @article.versions.reverse
        wants.html
        wants.xml { render :xml => @versions }
      end
    end
  end

  # GET /articles/1
  # GET /articles/1.xml
  def show
    @article = if params[:version]
      @revert_link = revert_article_path(params[:id], :version => params[:version])
      Article.find_by_title(params[:id]).versions.find(params[:version].to_i)
    else
      Article.find_by_title(params[:id])
    end
    respond_to do |format|
      unless @article
        format.html { redirect_to new_article_url(:title => params[:id]) }
        format.xml  { head 404 }
      else
        format.html # show.html.erb
        format.xml  { render :xml => @article }
      end
    end
  end

  # GET /articles/new
  # GET /articles/new.xml
  def new
    @article = Article.new
    @article.title = params[:title] if params[:title]

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @article }
    end
  end

  # GET /articles/1/edit
  def edit
    @article = Article.find_by_title(params[:id])
    unless @article
      redirect_to new_article_url(:title => params[:id])
    end
  end

  def revert
    @article = Article.find_by_title(params[:id])
    @article.revert_to(params[:version])
    
    respond_to do |format|
      if @article.save
        flash[:notice] = "Article reverted to version #{params[:version]}"
        format.html { redirect_to(@article) }
        format.xml  { head :ok }
      else
        format.html { redirect_to(@article) }
        format.xml  { render :xml => @article.errors, :status => :unprocessable_entity }
      end
    end
  end

  # POST /articles
  # POST /articles.xml
  def create
    @article = Article.new(params[:article])

    respond_to do |format|
      if @article.save
        flash[:notice] = 'Article was successfully created.'
        format.html { redirect_to(@article) }
        format.xml  { render :xml => @article, :status => :created, :location => @article }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @article.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /articles/1
  # PUT /articles/1.xml
  def update
    @article = Article.find_by_title(params[:id])

    respond_to do |format|
      if @article.update_attributes(params[:article])
        flash[:notice] = 'Article was successfully updated.'
        format.html { redirect_to(@article) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @article.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /articles/1
  # DELETE /articles/1.xml
  def destroy
    @article = Article.find_by_title(params[:id])
    @article.destroy

    respond_to do |format|
      format.html { redirect_to(articles_url) }
      format.xml  { head :ok }
    end
  end
end
