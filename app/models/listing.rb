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
    :housing

  def from(source)
    puts "\n\n\n\n\nsource attra_id [#{source.attra_id}] = [#{source.title}]"

    attributes = Hash.new
    [:title, :address, :city, :state, :zip, :contact, :contact_phones, :contact_emails, :contact_method, :website, :updated_on, :description, :internship_starts_on, :internship_ends_on, :num_interns, :app_deadline, :minimum_stay_length, :meals, :skills_desired, :educational_opportunities, :stipend, :housing].each do |attr|
      attributes[attr] = source.send(attr)
    end

    self.update_attributes!(attributes)
  end

end
