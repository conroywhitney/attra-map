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

  def from_attra(attra_listing)
    [:title, :address, :city, :state, :zip, :contact, :contact_phones, :contact_emails, :contact_method, :website, :updated_on, :description, :internship_starts_on, :internship_ends_on, :num_interns, :app_deadline, :minimum_stay_length, :meals, :skills_desired, :educational_opportunities, :stipend, :housing].each do |attribute|
      instance_variable_set("@#{attribute}", attra_listing.send(attribute))
    end
  end

end
