class ArtigosController < ApplicationController
  before_filter :carregar_artigo, :except => [:index, :new, :create]
  
  rescue_from 'ActiveRecord::RecordNotFound' do |e|
    redirect_to new_artigo_path(:titulo => params[:id])
  end
  
  # GET /artigos
  # GET /artigos.xml
  def index
    @artigos = Artigo.find(:all)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @artigos }
    end
  end

  # GET /artigos/1
  # GET /artigos/1.xml
  def show
    if params[:versao]
      @reverter_link = reverter_artigo_path(params[:id], :versao => params[:versao])
      @artigo = @artigo.versions.find(params[:versao].to_i)
    end
    
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @artigo }
    end
  end

  # GET /artigos/new
  # GET /artigos/new.xml
  def new
    @artigo = Artigo.new
    @artigo.titulo = params[:titulo] if params[:titulo]

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @artigo }
    end
  end

  # GET /artigos/1/edit
  def edit
  end

  # POST /artigos
  # POST /artigos.xml
  def create
    @artigo = Artigo.new(params[:artigo])

    respond_to do |format|
      if @artigo.save
        flash[:notice] = 'Artigo was successfully created.'
        format.html { redirect_to(@artigo) }
        format.xml  { render :xml => @artigo, :status => :created, :location => @artigo }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @artigo.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /artigos/1
  # PUT /artigos/1.xml
  def update
    respond_to do |format|
      if @artigo.update_attributes(params[:artigo])
        flash[:notice] = 'Artigo was successfully updated.'
        format.html { redirect_to(@artigo) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @artigo.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /artigos/1
  # DELETE /artigos/1.xml
  def destroy
    @artigo.destroy

    respond_to do |format|
      format.html { redirect_to(artigos_url) }
      format.xml  { head :ok }
    end
  end

  # GET /articles/MeuLink/versoes
  def versoes
    @versoes = @artigo.versions.reverse
  end
  
  # POST /articles/MeuLink/reverter
  def reverter
    @artigo.revert_to(params[:versao])
    if @artigo.save
      flash[:notice] = "Artigo revertido para a versão #{params[:versao]}"
    end
    redirect_to(@artigo)
  end
  
  
  private

    def carregar_artigo
      @artigo = Artigo.find_by_titulo(params[:id])
      raise ActiveRecord::RecordNotFound.new unless @artigo
    end
end
