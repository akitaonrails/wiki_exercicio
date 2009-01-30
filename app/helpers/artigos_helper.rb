module ArtigosHelper
  def reverter_link(artigo, reverter_link)
    link = if reverter_link
      link_to 'Reverter para esta versão', reverter_link, :confirm => "Certeza?", :method => :post
    else
      link_to 'Editar', edit_artigo_path(artigo)
    end
    link + " | "
  end

  def link_voltar(artigo, versao)
    link_to 'Voltar', versao ? versoes_artigo_path(artigo.titulo) : artigos_path
  end
end