require 'cgi'
require 'nokogiri'
require 'open-uri'

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

    def crawl!
      doc = Nokogiri::HTML(open(self.url))
      base_xpath = "//div[@id='main_content']//table//tr[1]//td//table//tr//td"

      sections = doc.xpath("#{base_xpath}//strong")

      self.title = sections.shift.content

      sections.each_with_index do |section, i|
        #puts "Section [#{section.content}] = Content [#{section.next.content}]"
      end

      return nil
    end

    def collect_between(first, last)
      first == last ? [first] : [first, *collect_between(first.next, last)]
    end

  end
end
