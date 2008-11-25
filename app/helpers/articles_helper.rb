module ArticlesHelper
  def revert_link(article, revert_link)
    link = if revert_link
      link_to 'Revert to this version', revert_link, 
        :confirm => "Sure?", :method => :post
    else
      link_to 'Edit', edit_article_path(article)
    end
    link + " | "
  end

  def back_link(article, version)
    if version
      link_to 'Back', versions_article_path(article.title)
    else
      link_to 'Back', articles_path
    end
  end
end