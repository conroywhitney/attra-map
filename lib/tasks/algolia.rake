namespace :algolia do

  desc "Refresh (destroy + create) all entries"
  task :refresh, [] => :environment do |t, args|
    puts "Refreshing algolia ..."
    # destroying first because received this great error...
    # Algolia::AlgoliaProtocolError: Cannot POST to https://4FQPTMXLRJ-2.algolia.net/1/indexes/Listing_development/batch: {"message":"Record quota exceeded, change plan or delete records."} (403)
    Rake::Task['algolia:destroy'].execute
    Rake::Task['algolia:create'].execute
    puts "... done"
  end

  desc "Remove all entries"
  task :destroy, [] => :environment do |t, args|
    puts " * destroying algolia"
    Adapters::Algolia.destroy_all
  end

  desc "Insert all entries"
  task :create, [] => :environment do |t, args|
    puts " * reindexing algolia"
    Adapters::Algolia.reindex!
  end

end


