class CreateCrawledPages < ActiveRecord::Migration
  def change
    create_table :crawled_pages do |t|
      t.string   :type
      t.string   :digest
      t.string   :url
      t.text     :html
      t.timestamps
    end
  end
end
