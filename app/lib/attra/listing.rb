require 'cgi'

module Attra
  class Listing < Attra::Page

    # https://attra.ncat.org/attra-pub/internships/farmdetails.php?FarmName=&City=&State=OR&Keyword=&allDate=0&page=1&FarmID=3391

    attr_accessor \
      :attra_id,
      :title,
      :address,
      :city,
      :state,
      :zip,
      :contact,
      :contact_phones,
      :contact_emails,
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
      :internship_details


    def self.qs_keys
      return {
        attra_id:  "FarmID",
        farm_name: "FarmName",
        city:      "City",
        state:     "State",
        keyword:   "Keyword",
        all_date:  "allDate",
        page:      "page"
      }
    end

    def details
      # you can't send instance varialbes into Wombat block
      options = {
        base_url: self.base_url,
        path:     self.path
      }

      results = Wombat.crawl do
        base_url options[:base_url]
        path options[:path]

        # loop through all tables and pull out details urls
        listings "xpath=//div[@id='main_content']//table", :iterator do
          name({  xpath: "*//strong" })
          url({   xpath: "*//a/@href" })
        end
      end

      # clean results from messy DOM structure
      return results["listings"].collect do |listing|
        listing["url"]
      end.select do |url|
        url.present? && url.include?("farmdetails.php")
      end
    end

  end
end
