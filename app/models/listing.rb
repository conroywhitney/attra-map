class Listing < ActiveRecord::Base

  attr_accessible \
    :title,
    :address,
    :city,
    :state,
    :zip,
    :contact,
    :contact_phones,
    :contact_emails,
    :contact_method,
    :website,
    :updated_on,
    :description,
    :internship_starts_on,
    :internship_ends_on,
    :num_interns,
    :app_deadline,
    :minimum_stay_length,
    :meals,
    :skills_desired,
    :educational_opportunities,
    :stipend,
    :housing,
    :fulltext_search

  geocoded_by :postal_address, :latitude => :lat, :longitude => :lon

  after_validation :geocode, if: ->(obj){ obj.lat.blank? || obj.lon.blank? && obj.postal_address.present? }

  def postal_address
    [self.address, self.city, self.state, self.zip].reject{|e| e.nil?}.join(", ")
  end

  def url
    return "https://attra.ncat.org/attra-pub/internships/farmdetails.php?FarmID=#{self.attra_id}"
  end

  def self.for(listing)
    listing_class = listing.class.name
    case listing_class
    when "Adapters::Listings::Karnes"
      return listing
    when "KarnesFeedItem"
      return Adapters::Listings::Karnes.new(listing)
    else
      raise "Unable to find listing adapter for class [#{listing_class}]"
    end
  end

  def from(source)
    attributes = Hash.new
    [:title, :address, :city, :state, :zip, :contact, :contact_phones, :contact_emails, :contact_method, :website, :updated_on, :description, :internship_starts_on, :internship_ends_on, :num_interns, :app_deadline, :minimum_stay_length, :meals, :skills_desired, :educational_opportunities, :stipend, :housing, :fulltext_search].each do |attr|
      attributes[attr] = source.send(attr)
    end
    self.update_attributes!(attributes)
  end

end
