class AdicionarVersionamentoAoArtigo < ActiveRecord::Migration
  def self.up
    Artigo.create_versioned_table
  end

  def self.down
    Artigo.drop_versioned_table
  end
end
