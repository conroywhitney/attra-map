
namespace :listings do

  desc "Geocode uncoded listings"
  task :geocode, [] => :environment do |t, args|
    # rake geocode:all CLASS=Listing
  end

end


