require 'wombat'

namespace :attra do

  desc "Pull all listings into database"
  task :crawl, [] => :environment do |t, args|
    listings = []
    all = "https://attra.ncat.org/attra-pub/internships/search_results.php?FarmName=&City=&State=&Keyword=&allDate=1&Go=Go"
    oregon = "https://attra.ncat.org/attra-pub/internships/search_results.php?State=OR"
    washington = "https://attra.ncat.org/attra-pub/internships/search_results.php?State=WA"
    california = "https://attra.ncat.org/attra-pub/internships/search_results.php?State=CA"

    serp = Attra::Serp.new(california)
    while serp.valid? do
      puts "Scanning URL [#{serp.url}]...\tFound [#{serp.listings.count}] listings..."
      serp.listings.each do |url|
        listings << Attra::Listing.new(url)
      end
      serp = Attra::Serp.new(serp.next_url)
    end

    puts ["Address", "City", "State", "Zip", "Title", "URL"].join("\t")
    listings.each do |listing|
      listing.crawl!
      puts [listing.address, listing.city, listing.state, listing.zip, listing.title, listing.url].join("\t")
    end

  end

end

