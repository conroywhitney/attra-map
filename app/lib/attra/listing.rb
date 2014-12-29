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

    def self.section_labels
      return {
        contact: "Contact",
        contact_phones: "Phone",
        contact_emails: "Email",
        website: "Website",
        updated_on: "Last Updated",
        description: "General Description",
        internship_starts_on: "Internship Starts",
        internship_ends_on: "Internship Ends",
        num_interns: "Number of Interns",
        app_deadline: "App Deadline",
        minimum_stay_length: "Minimum Length of Stay",
        meals: "Meals",
        skills_desired: "Skills Desired",
        educational_opportunities: "Educational Opportunities",
        stipend: "Stipend",
        housing: "Housing",
        contact_method: "Preferred method Of Contact",
        internship_details: "Internship Details"
      }.reverse
    end

    def crawl!
      doc = Nokogiri::HTML(open(self.url))
      base_xpath = "//div[@id='main_content']//table//tr[1]//td//table//tr//td"

      details  = doc.xpath("#{base_xpath}")
      sections = details.xpath(".//strong")

      0.upto(sections.length - 1) do |i|
        elements = collect_between(sections[i], sections[i + 1])
        puts "Section [#{sections[i]}] = [#{elements}]"
      end

      self.title = sections.shift.content

      return nil
    end

    def parse(content, section)
      puts content.to_s
    end

    def content_between(first, last)
      elements = collect_between(first, last)
      return elements.collect{|e| e.content}.join("\t")
    end

    def collect_between(first, last)
      first == last ? [first] : [first, *collect_between(first.next, last)]
    end

  end
end
