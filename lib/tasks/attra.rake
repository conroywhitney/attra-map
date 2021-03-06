require 'wombat'
require 'digest/md5'

namespace :attra do

  desc "Pull all listings into database"
  task :crawl, [:url] => :environment do |t, args|
    args.with_defaults(:url => "https://attra.ncat.org/attra-pub/internships/search_results.php?FarmName=&City=&State=&Keyword=&allDate=1&Go=Go")

    attra_listings = []
    serp_url = args.url

    begin
      serp = Attra::Serp.where(digest: Digest::MD5.hexdigest(serp_url)).first_or_create do |serp|
        serp.url = serp_url
      end

      serp_listings = serp.listings

      puts "Scanning URL [#{serp.url}]...\tFound [#{serp_listings.count}] listings..."
      serp_listings.each do |url|
        attra_listings << Attra::Listing.where(digest: Digest::MD5.hexdigest(url)).first_or_create do |attra_listing|
          attra_listing.url = url
        end
      end

      serp_url = serp.next_url
    end while serp_listings.count > 0

    attra_listings.each do |attra_listing|
      attra_listing.cached_or_crawl!

      listing = Listing.where(attra_id: attra_listing.attra_id).first_or_create
      begin
        listing.from(attra_listing)
        listing.save!
      rescue => e
        puts "Error saving [#{attra_listing.attra_id}]: [#{e.message}]"
      end
    end

  end

  desc "Go back through and re-parse / re-save everything"
  task :refresh, [] => :environment do |t, args|
    Attra::Listing.find_each do |listing|
      listing.parse!
      listing.save!
    end
  end


end

