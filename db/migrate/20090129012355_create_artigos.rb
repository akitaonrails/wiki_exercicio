class CreateArtigos < ActiveRecord::Migration
  def self.up
    create_table :artigos do |t|
      t.string :titulo
      t.text :conteudo
      t.text :conteudo_html

      t.timestamps
    end
  end

  def self.down
    drop_table :artigos
  end
end
