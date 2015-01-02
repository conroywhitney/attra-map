
namespace :listings do

  desc "Geocode uncoded listings"
  task :geocode, [] => :environment do |t, args|
    count = Listing.count("lat IS NULL OR lon IS NULL")

    puts "Going to geocode [#{count}] items, OK?"

    Listing.where("lat IS NULL OR lon IS NULL").find_each do |listing|
    end
  end

end


