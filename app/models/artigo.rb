class Artigo < ActiveRecord::Base
  acts_as_versioned :if_changed => [:titulo, :conteudo]

  include ActionController::UrlWriter
  
  validates_presence_of :titulo
  validates_presence_of :conteudo
  validates_format_of :titulo, :with => /^[a-z|A-Z|0-9]+$/, :message => "não pode conter espaços em branco"
    
  before_save :converter_markdown
  before_save :converter_links
  
  def to_param
    self.titulo
  end
  
  private
  def converter_markdown
    self.conteudo_html = RedCloth.new( self.conteudo ).to_html
  end
  
  def converter_links
    if self.conteudo_html && self.conteudo_html =~ /\[([^\s]+?)\]/
      self.conteudo_html.gsub!(/\[([^\s]+?)\]/, '<a href="/artigos/\1">\1</a>')
    end
  end

end
