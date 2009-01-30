require 'test_helper'

class ArtigoTest < ActiveSupport::TestCase

	test "nao pode salvar modelo vazio" do
		@artigo = Artigo.new 
		assert !@artigo.valid?
		assert @artigo.errors[:titulo]
		assert @artigo.errors[:conteudo]
	end
	
	test "deve converter formato markdown para HTML" do
	 @artigo = Artigo.new :titulo => 'teste', :conteudo => '*bla* _bla_'
	 assert @artigo.save
	 assert_equal @artigo.conteudo_html, '<p><strong>bla</strong> <em>bla</em></p>'
	end
end
