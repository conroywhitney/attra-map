namespace :algolia do

  desc "Refresh (destroy + create) all entries"
  task :refresh, [] => :environment do |t, args|
    puts "Refreshing algolia ..."
    # don't need to destroy -- #reindex! will destroy old index
    # Rake::Task['algolia:destroy'].execute
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


