class CreateListings < ActiveRecord::Migration
  def change
    create_table :listings do |t|
      t.string   :title
      t.string   :address
      t.string   :city
      t.string   :state
      t.string   :zip
      t.decimal  :lat, precision: 10, scale: 6
      t.decimal  :lon, precision: 10, scale: 6
      t.string   :contact
      t.string   :contact_phones
      t.string   :contact_emails
      t.string   :contact_method
      t.string   :website
      t.string   :updated_on
      t.string   :description
      t.string   :internship_starts_on
      t.string   :internship_ends_on
      t.string   :num_interns
      t.string   :app_deadline
      t.string   :minimum_stay_length
      t.string   :meals
      t.string   :skills_desired
      t.string   :educational_opportunities
      t.string   :stipend
      t.string   :housing
      t.string   :internship_details
      t.integer  :attra_id
      t.timestamps
    end
  end
end
