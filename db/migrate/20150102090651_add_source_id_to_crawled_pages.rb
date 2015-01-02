class AddSourceIdToCrawledPages < ActiveRecord::Migration
  def change
    add_column :crawled_pages, :source_id, :integer
  end
end
