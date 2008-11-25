class Article < ActiveRecord::Base
  acts_as_versioned :if_changed => [:title, :body]
  include ActionController::UrlWriter
  
  validates_presence_of :title, :body
  before_save :convert_markdown
  before_save :convert_links
  
  def to_param
    self.title
  end
  
  def validate
    unless title !~ /\s/ && title.chars[0].to_s =~ /[A-Z]/
      errors.add("title", "is invalid")
    end
  end
  
  private
  def convert_markdown
    convert = RedCloth.new self.body
    self.html = convert.to_html
  end
  
  def convert_links
    if self.html && self.html =~ /\[([^\s]+)\]/
      self.html.gsub!(/\[([^\s]+)\]/,
        "<a href=\"#{article_path($1)}\">#{$1}</a>")
    end
  end
end
