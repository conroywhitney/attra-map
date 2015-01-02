
namespace :listings do

  desc "Geocode uncoded listings"
  task :geocode, [] => :environment do |t, args|
    # rake geocode:all CLASS=Listing
  end

  desc "Update listing information from attra source"
  task :refresh, [] => :environment do |t, args|
    Listing.find_each do |listing|
      attra_listing = Attra::Listing.where(source_id: listing.attra_id).first
      attra_listing.parse!

      listing.from(attra_listing)
      listing.save!
    end
  end

end


