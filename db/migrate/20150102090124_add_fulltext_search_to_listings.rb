class AddFulltextSearchToListings < ActiveRecord::Migration
  def change
    add_column :listings, :fulltext_search, :text
  end
end
