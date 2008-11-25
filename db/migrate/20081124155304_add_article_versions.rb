class AddArticleVersions < ActiveRecord::Migration
  def self.up
    Article.create_versioned_table
  end

  def self.down
    Article.drop_versioned_table
  end
end